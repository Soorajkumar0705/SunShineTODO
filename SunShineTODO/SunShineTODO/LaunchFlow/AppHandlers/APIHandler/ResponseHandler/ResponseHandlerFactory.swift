//
//  ResponseHandlerFactory.swift
//  Kado
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


protocol ResponseHandlerFactoryType {
    func makeResponseHandler() -> ResponseHandlerType
}

class ResponseHandlerFactory : ResponseHandlerFactoryType{
    
    func makeResponseHandler() -> ResponseHandlerType{
        ResponseHandler()
    }
    
}
