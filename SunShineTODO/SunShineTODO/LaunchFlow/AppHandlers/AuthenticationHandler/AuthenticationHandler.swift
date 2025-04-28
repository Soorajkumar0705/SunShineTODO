//
//  AuthenticationHandler.swift
//  Kado
//
//  Created by Suraj kahar on 27/02/25.
//

import Foundation

class AuthenticationHandlerFactory {
    
    func makeAuthHandler() -> AuthenticationHandler {
        AuthenticationHandler()
    }
}

class AuthenticationHandler : LaunchFlow {

    @Storage(key: .isOnboardingVisited, defaultValue: false) var isOnboardingVisited: Bool

    @Storage(key: .isSignIn, defaultValue: false) var isSignedIn: Bool
    @Storage(key: .sessionToken, defaultValue: "") var sessionToken: String
    
//    @Storage(key: .userId, defaultValue: -1) var userData: User
    
    
  
    
    static let shared: AuthenticationHandler = AuthenticationHandlerFactory().makeAuthHandler()

    
    func start() {
        Logger.logMessage("\(className) is started successfully.")
    }
    
    func removeAuthenticationDetails(){
        
        isSignedIn = false
        sessionToken = ""
        ImageCacheManager.shared.clearCache()
    }
    
    
}
