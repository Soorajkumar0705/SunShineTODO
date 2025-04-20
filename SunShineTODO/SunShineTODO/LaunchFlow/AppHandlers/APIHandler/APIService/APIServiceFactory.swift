//
//  APIServiceFactory.swift
//  Kado
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


protocol APIServiceFactoryType {
    func makeAPIService() -> APIServiceProtocol
}

class APIServiceFactory : APIServiceFactoryType{
    
    func makeAPIService() -> any APIServiceProtocol {
        APIService(
            networkHandler: NetworkHandlerFactory().makeNetworkHandler(),
            responseHandler: ResponseHandlerFactory().makeResponseHandler()
        )
    }
    
}
