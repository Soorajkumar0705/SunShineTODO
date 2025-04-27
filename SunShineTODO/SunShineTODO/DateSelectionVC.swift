//
//  DateSelectionVC.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import UIKit

class DateSelectionVC : UIViewController, StoryboardBased{
    
    @IBOutlet private weak var popUpContainerView: CornerRadiusView!
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    
    var bgDimView: UIView = UIView(frame: .zero)
    
    var _popUpContainerView: UIView {
        popUpContainerView
    }
    
    var isHideOnBGClick: Bool {
        true
    }

    
    var didSelectedDate : ( (Date) -> Void )?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentPopUpViewWithAnimation(dimViewColor: .black, dimViewAlpha: 0.5)
    }
    
    func updateInitialUIConfiguration() {
        
    }
    
    @IBAction private func onClickBtnDone(_ sender: UIButton) {
        
        if datePicker.date > Date() {
            didSelectedDate?(datePicker.date)
            removeChildVC(self)
        }else{
            Toast.show("Please select a valid date.")
        }
        
        print(#function)
    }
    
    
}

extension DateSelectionVC {
    
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
