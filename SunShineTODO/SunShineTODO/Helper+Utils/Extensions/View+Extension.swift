//
//  View+Extension.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//


import SwiftUI

extension View {
    
    func toVC() -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        
        // Embed SwiftUI view using UIHostingController
        let hostingController = UIHostingController(rootView: self)
        
        // Add as a child view controller
        vc.addChild(hostingController)
        vc.view.addSubview(hostingController.view)
        hostingController.view.frame = vc.view.bounds

        hostingController.didMove(toParent: vc)
        
        return vc
    }
    
}
