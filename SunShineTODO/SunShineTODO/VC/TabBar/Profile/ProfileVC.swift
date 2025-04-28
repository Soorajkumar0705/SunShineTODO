//
//  ProfileVC.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//

import UIKit
import SwiftUI

class ProfileVC: UIViewController, StoryboardBased {

    
    @IBOutlet private weak var imgProfileImage: UIImageView!
    @IBOutlet private weak var lbluserName: UILabel!
    
    @IBOutlet private weak var tblOptions: ProfileOptionsTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInitialUIConfiguration()
    }
    
    
    func updateInitialUIConfiguration() {
        tblOptions.layer.cornerRadius = 24
        tblOptions.layer.borderWidth = 1
        tblOptions.layer.borderColor = UIColor._91919_F.withAlphaComponent(0.4).cgColor
        tblOptions.clipsToBounds = true
        
        tblOptions.configure(with: ProfileOptions.allCases)
        tblOptions.didSelectedItem = { [weak self] (indexPath, dataItem, cell) in
            guard let self else { return }
            
            switch dataItem {
            case .settings:
                Toast.show("In progress, will bring it to you soon.")
                
            case .logout:
                showLogoutPopUp()
            }
            
        }
    }
    
    private func showLogoutPopUp() {
        
        let vc = PopUpVCFactory().make()
        
        vc.onClickBtnNo = { [weak self] in
            guard let _ = self else { return }
            
        }
        
        vc.onClickBtnYes = { [weak self] in
            guard let _ = self else { return }
            AuthenticationHandler.shared.removeAuthenticationDetails()
            let vc = SignUpORSignInScreenFactory().makeVC(authType: .signIn)
            AppNavigationCoordinator.shared.setRootVC(vc)
        }
        
        vc.presentAsChildVCInTabBarVC(in: self, animated: true)
    }
    

}
