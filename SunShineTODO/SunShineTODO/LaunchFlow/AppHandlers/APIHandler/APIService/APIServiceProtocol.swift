//
//  APIServiceProtocol.swift
//  Kado
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation

//MARK: -  APIServiceProtocol

protocol APIServiceProtocol: NSObjectProtocol {
    
    var networkHandler : NetworkHandlerType { get }
    var responseHandler : ResponseHandlerType { get }
    
    
    func getData< S : CodableResponseModel>(
        endpoint : APIEndpointEnumType,
        useCustomParser : Bool,
        successResponseModelType : S.Type
        
    ) async throws -> S
    
}

