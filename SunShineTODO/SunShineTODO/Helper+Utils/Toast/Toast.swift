//
//  Toast.swift
//  Kado
//
//  Created by Harsh on 09/04/25.
//

import UIKit

class Toast{
    
    private static var toastView : ToastMessageView?
    private static var hideToastTimer: Timer?
    
    static func show(_ message : String, bottomMargin: CGFloat? = nil ) {
        hide()
        guard let activeVC = AppDelegate.getAppDelegateRef()?.getActiveVC() else { return }
        
        let toastView = ToastMessageView(message: message, bottomMargin: bottomMargin ?? 20.0)
        
        toastView.alpha = 0
        
        activeVC.showPopUpView(toastView)
        self.toastView = toastView
        
        UIView.animate(withDuration: 1, animations: {
            toastView.alpha = 1
        }, completion: {_ in
            
            hideToastTimer =
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { _ in
                
                UIView.animate(withDuration: 0.7, animations: {
                    toastView.alpha = 0
                    
                }, completion: {_ in
                    
                    hide()
                })
                
            })
        })  // UIView.animate(withDuration: 1
        
    }
    
    static func hide(){
        hideToastTimer?.invalidate()
        hideToastTimer = nil
        toastView?.removeFromSuperview()
        toastView = nil
    }
    
}

