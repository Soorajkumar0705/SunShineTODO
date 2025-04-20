//
//  Loader.swift
//  Kado
//
//  Created by Harsh on 10/04/25.
//


import UIKit

class Loader{
    
    private static var loaderView : LoaderView?
    
    static func show() {
        guard let activeVC = AppDelegate.getAppDelegateRef()?.getActiveVC() else { return }
        
        loaderView?.removeFromSuperview()
        loaderView = nil
        
        loaderView = LoaderView()
        activeVC.showPopUpView(loaderView!)
    }
    
    static func hide(){
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
    
}
