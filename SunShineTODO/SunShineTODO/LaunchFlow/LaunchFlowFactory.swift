//
//  LaunchFlowFactory.swift
//  Kado
//
//  Created by Suraj kahar on 27/02/25.
//


import Foundation

protocol LaunchFlowFactoryType: AnyObject {
    func makeLaunchFlows() -> [LaunchFlow]
}

class LaunchFlowFactory: LaunchFlowFactoryType {
    func makeLaunchFlows() -> [LaunchFlow] {
        return [
            NetworkReachability.shared,
            AuthenticationHandler.shared,
            AppNavigationCoordinator.shared,
            PermissionHandler.shared
        ]
    }
}
