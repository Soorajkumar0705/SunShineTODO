//
//  StoryboardBased.swift
//  Kado
//
//  Created by Suraj kahar on 10/02/25.
//

import UIKit

protocol StoryboardBased where Self : UIViewController{
    
   
    /**
     
     This method will create  a instance of the `ViewController` for which this Static method will be called
     
     - parameter storyboard: The story board `instance` in which the the `ViewController` is designed
     - Returns: `ViewController` instance for which this method was called
     
     
     Example Usage
     
     ``` swift
     let vc = ViewController.instantiate(from: .main)
     
     // Here the main in the parameter is the storyboard instance of "Main.storyboard"
     // And vc is the instance of `ViewController` which we have requested for
     ```
     
     */
    static func instantiate(from storyboard: UIStoryboard) -> Self
    
    
    /**
     
     This function will be used to initiate and set a `root`  `ViewController` in the current window.
     
     
     Example Usage
     
     ``` swift
     let vc = ViewController.instantiate(from: .main)
     vc.rootVC()
     
     // Here the main is the storyboard instance of "Main.storyboard"
     // provide a custom implementation or use the default one of the method
     
     ```
     
     */
    func rootVC()
    
    
    /**
     
     Method can be use to present any view controller in the current navigation stack
     
     - Parameters:
       - presenterVC: current view controller to help and fetch the current navigation controller to present this vc
       - animated: animation while presenting the vc
     
     Example usage
     
     ``` swift
     let vc = ViewController.instantiate(from: .main)
     vc.presentVC(in self, animated : true)
     ```
     
     */
    func presentVC(in presenterVC: UIViewController, animated: Bool)
    
    
    /**
     
     Method can be use to push any view controller in the current navigation stack
     
     - Parameters:
       - presenterVC: current view controller to help and fetch the current navigation controller to push this vc
       - animated: animation while pushing the vc
     
     Example usage
     
     ``` swift
     let vc = ViewController.instantiate(from: .main)
     vc.pushVC(in self, animated : true)
     ```
     
     */
    func pushVC(in presenterVC: UIViewController, animated: Bool)
    
    
    func presentAsChildVC(in presenterVC: UIViewController, animated: Bool)
    
    
    /**
     For Initial UI Configuration
     
     - This method can be help full when you have some update to make with UI when initially a view controller launches.
     
     - you can use to call this method in the lifecycle suitable as per your code requirements
     
     * Lifecycles to call this method:
     
     1. loadView()
     2. viewDidLoad()
     3. viewWillAppear()
     
     Example usage
     
     ``` swift
     override func viewDidLoad() {
         super.viewDidLoad()
         updateInitialUIConfiguration()
     }
     
     func updateInitialUIConfiguration() {
         // Do Your Initial configuration
         someView.backgroundColor = .red
         someView.layer.cornerRadius = 10
     }
     ```
     
     */
    func updateInitialUIConfiguration()
   
}


//MARK: - Default Implementation

extension StoryboardBased where Self: UIViewController {
    
    static func instantiate(from storyboard: UIStoryboard) -> Self {
//        fatalError("View Controller:(\(className)) not found in the specified storyboard: \(storyboard)")
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
    
    func updateInitialUIConfiguration(){
        
    }
    
    func rootVC() {
        AppNavigationCoordinator.shared.setRootVC(self)
    }
    
    func presentVC(in presenterVC: UIViewController, animated: Bool){
        presenterVC.navigationController?.present(self, animated: animated)
    }
    
    func pushVC(in presenterVC: UIViewController, animated: Bool){
        presenterVC.navigationController?.pushViewController(self, animated: animated)
    }
    
    func presentAsChildVC(in presenterVC: UIViewController, animated: Bool){
        self.view.frame = presenterVC.view.bounds
        presenterVC.view.addSubview(self.view)
        presenterVC.addChild(self)
    }
    
    func presentAsChildVCInTabBarVC(in presenterVC: UIViewController, animated: Bool){
        guard let tabBarVC = presenterVC.tabBarController else { return }
        
        self.view.frame = tabBarVC.view.bounds
        tabBarVC.view.addSubview(self.view)
        tabBarVC.addChild(self)
    }
    
    func removeChildVC(_ vc : UIViewController){
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    // SOME HELPER METHODS
    
    func popVC(animated: Bool = true){
        self.navigationController?.popViewController(animated: animated)
    }
    

    func hideNavigationBar(){
        self.navigationController?.isNavigationBarHidden = true
    }

    func showNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
    }
    
}
