//
//  NetworkHandlerType.swift
//  Kado
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation

//MARK: - NetworkHandlerType

protocol NetworkHandlerType {
    
    var requestFactory : RequestFactoryType { get }
    
    func requestDataAPI(
        endpoint : APIEndpointType
        
    )  async throws -> Data
}
