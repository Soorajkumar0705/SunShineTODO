//
//  AuthenticationEndPoint.swift
//  iOSModule
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation

enum AuthenticationEndPointEnum  {
    
    case signIn(paramBody : JsonRequestBodyType)
    case registerUser(paramBody : JsonRequestBodyType)
    case signOut
    case deleteAccount
        
}

extension AuthenticationEndPointEnum: APIEndpointEnumType {
    
    func getEndpoint() -> (any APIEndpointType) {
        
        switch self {
            
        case .registerUser(paramBody: let paramBody):
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "register",
                method: HTTPMethod.POST,
                headers: defaultHeader,
                params: HTTPParamRequestBody(body: paramBody)
            )
            
        case .signIn(paramBody: let paramBody):
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "login",
                method: HTTPMethod.POST,
                headers: defaultHeader,
                params: HTTPParamRequestBody(body: paramBody)
            )
            
        case .signOut:
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "signout",
                method: HTTPMethod.POST,
                headers: [
                    headers_wildCard,
                    headers_applicationJson,
                    getSessionTokenHeader()
                ],
                params: nil
            )
            
        case .deleteAccount:
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "user/delete-account",
                method: HTTPMethod.POST,
                headers: [
                    headers_wildCard,
                    headers_applicationJson,
                    getSessionTokenHeader()
                ],
                params: nil
            )
            
        }
    }
    
}
