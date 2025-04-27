//
//  SideMenuVC.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//

import UIKit

class SideMenuVC: UIViewController, StoryboardBased {

    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentVCWithAnimation()
        updateUI()
    }
    
    private func updateUI(){
       
        bgView.addTapGesture(action: { [weak self] _ in
            guard let self else { return }
            removeChildVC(self)
        })
        
    }
    
    
    private func presentVCWithAnimation(){
        
        containerView.frame.origin.x -= (containerView.frame.width + 100)
        containerView.isHidden = false
        
        CommonFunctions.generateHapticFeedback()
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = .black.withAlphaComponent(0.25)
            containerView.frame.origin.x += (containerView.frame.width + 100)
        })
        
        
    }
    
    
    @IBAction private func onClickBtnLogout(_ sender: UIButton) {
        AuthenticationHandler.shared.removeAuthenticationDetails()
        let vc = SignUpORSignInScreenFactory().makeVC(authType: .signIn)
        AppNavigationCoordinator.shared.setRootVC(vc)
        print(#function)
    }
    
}
