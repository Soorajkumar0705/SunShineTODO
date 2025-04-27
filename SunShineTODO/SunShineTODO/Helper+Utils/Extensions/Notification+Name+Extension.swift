//
//  Extension+Notification+Name.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import Foundation

extension Notification.Name {
    
    static let applicationDidEnterBackground = Notification.Name("applicationDidEnterBackground")
    static let applicationWillEnterForeground = Notification.Name("applicationWillEnterForeground")
    
    static let applicationDidBecomeActive = Notification.Name("applicationDidBecomeActive")
    static let applicationWillResignActive = Notification.Name("applicationWillResignActive")
    
    
    static let didReceiveCreateToDoResponse = Notification.Name("didReceiveCreateToDoResponse")
    
    static let didStopSplashScreenVideoPlaying = Notification.Name("didStopSplashScreenVideoPlaying")
}


