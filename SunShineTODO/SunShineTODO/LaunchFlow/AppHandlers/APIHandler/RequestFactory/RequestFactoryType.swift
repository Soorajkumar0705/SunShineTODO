//
//  RequestFactoryType.swift
//  Kado
//
//  Created by Suraj kahar on 02/03/25.
//

import Foundation


protocol RequestFactoryType {
    
    func getRequest(for endpoint : APIEndpointType) throws -> URLRequest
    
}
