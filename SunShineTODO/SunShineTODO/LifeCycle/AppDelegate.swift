//
//  AppDelegate.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 19/04/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        LaunchFlowFactory().makeLaunchFlows().forEach( { $0.start() })
        
        return true
    }


}

extension AppDelegate {
    
    // MARK: - OTHER CONFIGURING METHODS
    
    static func getAppDelegateRef() -> Self?{
        return UIApplication.shared.delegate as? Self
    }
    
    func getActiveVC() -> UIViewController?{
        guard let vc = (self.window?.rootViewController as? UINavigationController)?.viewControllers.last else{
            print("Not found the root view controller as? UIViewController in ",#function)
            return nil
        }
        return vc
    }   // getActiveVC
    
    
}
