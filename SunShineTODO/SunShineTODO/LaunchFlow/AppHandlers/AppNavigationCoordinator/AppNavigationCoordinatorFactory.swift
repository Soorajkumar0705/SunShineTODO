//
//  AppNavigationCoordinatorFactory.swift
//  Kado
//
//  Created by Suraj kahar on 28/02/25.
//

import Foundation

protocol AppNavigationCoordinatorFactoryType: AnyObject {
    func makeNavigationCoordinator() -> AppNavigationCoordinatorType
}

class AppNavigationCoordinatorFactory: AppNavigationCoordinatorFactoryType {
    
    func makeNavigationCoordinator() -> AppNavigationCoordinatorType {
        return AppNavigationCoordinator.shared
    }
}
