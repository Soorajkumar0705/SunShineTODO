//
//  AppNavigationCoordinator.swift
//  Kado
//
//  Created by Suraj kahar on 28/02/25.
//

import UIKit


protocol AppNavigationCoordinatorType : LaunchFlow{
    
    var window : UIWindow? { get set }
    var navigationController : UINavigationController! { get set }
    
    func setRootVC(_ viewController: UIViewController)

    
}

extension AppNavigationCoordinatorType {
    
    func setRootVC(_ viewController: UIViewController) {
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        if navigationController == nil {
            navigationController = UINavigationController()
            navigationController?.viewControllers = [viewController]
            
        }else{
            
            navigationController?.viewControllers.append(viewController)
            navigationController?.viewControllers.removeAll(where: { $0 != viewController })

        }
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.isHidden = true
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        self.window?.overrideUserInterfaceStyle = .light
    }
    
}

class AppNavigationCoordinator : AppNavigationCoordinatorType{
    
    static let shared = AppNavigationCoordinator()
    
    private init() {}
    
    var window : UIWindow? {
        get{
            (UIApplication.shared.delegate as? AppDelegate)?.window
        }
        set{
            (UIApplication.shared.delegate as? AppDelegate)?.window = newValue
        }
    }
    var navigationController: UINavigationController!
    
    
    func start() {

        let vc : UIViewController =
        
        if AuthenticationHandler.shared.isSignedIn {
            HomeVC.instantiate(from: .main)
        }else{
            TabBarVCFactory().makeVC()
        }
        
        setRootVC(vc)
        
        Logger.logMessage("\(className) is started successfully.")
    }
    
}
