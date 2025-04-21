//
//  UDStorageKey.swift
//  Kado
//
//  Created by Suraj kahar on 28/02/25.
//

import Foundation


enum UDStorageKey: String, CaseIterable {

    case isOnboardingVisited
    
    case isSignIn = "isSignIn"
    case sessionToken = "X-Session-Token"
    case userProfileData
    case userId = "Current-User-Id"
    case isProfileCreated = "isProfileCreated"
    
    
    case taskData
    
    
}

