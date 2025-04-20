//
//  NetworkHandlerFactory.swift
//  Kado
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


protocol NetworkHandlerFactoryType {
    func makeNetworkHandler() -> NetworkHandlerType
}

class NetworkHandlerFactory : NetworkHandlerFactoryType{
    
    func makeNetworkHandler() -> any NetworkHandlerType {
        NetworkHandler(
            requestFactory: RequestFactoryMaker().makeRequestFactory()
        )
    }
    
}
