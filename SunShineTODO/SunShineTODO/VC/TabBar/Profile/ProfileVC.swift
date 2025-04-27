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
    }
    

}
