//
//  RequestFactoryMaker.swift
//  Kado
//
//  Created by Suraj kahar on 02/03/25.
//

import Foundation

protocol RequestFactoryMakerType {
    
    func makeRequestFactory() -> RequestFactoryType
    
}

class RequestFactoryMaker : RequestFactoryMakerType{
    
    func makeRequestFactory() -> any RequestFactoryType {
        RequestFactory()
    }
    
}
