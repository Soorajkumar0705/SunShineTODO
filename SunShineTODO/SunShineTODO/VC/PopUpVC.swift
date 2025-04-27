//
//  PopUpVC.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//

import UIKit

class PopUpVCFactory {
    
    private var title : String?
    private var message : String?
    
    
    func setTitle(_ title : String) -> PopUpVCFactory {
        self.title = title
        return self
    }
    
    func setMessage(_ message : String) -> PopUpVCFactory {
        self.message = message
        return self
    }
    
    func make() -> PopUpVC {
        let vc = PopUpVC.instantiate(from: .tabBar)
        
        if let title{
            vc.title = title
        }
        
        if let message{
            vc.message = message
        }
        
        return vc
    }
    
}

class PopUpVC  : UIViewController, StoryboardBased {
    
    @IBOutlet private weak var popUpContainerView: CornerRadiusView!
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblMessage: UILabel!
    
    
    var bgDimView: UIView = UIView(frame: .zero)
    
    var _popUpContainerView: UIView {
        popUpContainerView
    }
    
    var isHideOnBGClick: Bool {
        true
    }

    
    var popUpTitle : String = "Logout?"
    var message : String = "Are you sure you want to logout?"
    
    
    var onClickBtnNo: (() -> Void)?
    var onClickBtnYes: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentPopUpViewWithAnimation(dimViewColor: .black, dimViewAlpha: 0.5)
        updateInitialUIConfiguration()
    }
    
    func updateInitialUIConfiguration() {
        lblTitle.text = popUpTitle
        lblMessage.text = message
    }
    
    @IBAction private func onClickBtnNo(_ sender : UIButton) {
        onClickBtnNo?()
        removeChildVC(self)
        print(#function)
    }
    
    
    @IBAction private func onClickBtnYes(_ sender : UIButton) {
        onClickBtnYes?()
        removeChildVC(self)
        print(#function)
    }
    
    
}

extension PopUpVC {

    func presentPopUpViewWithAnimation(dimViewColor: UIColor, dimViewAlpha: CGFloat){
        bgDimView.frame = self.view.bounds
        bgDimView.backgroundColor = dimViewColor.withAlphaComponent(dimViewAlpha)
        bgDimView.alpha = 0
        self.view.insertSubview(bgDimView, at: 0)
        
        UIView.animate(withDuration: 0.25, animations: {[weak self] in
            self?.bgDimView.alpha = 1
        })
        
        bgDimView.addTapGesture(action: { [weak self] _ in
            guard let self else { return }
            removeChildVC(self)
        })
    }
    
}
