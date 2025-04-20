//
//  ResponseHandlerType.swift
//  Kado
//
//  Created by Suraj kahar on 01/03/25.
//

import Foundation


//MARK: - ResponseHandlerType

protocol ResponseHandlerType {
    
    func parseResponseWithJSONDecoder<T: CodableResponseModel>(
        data: Data,
        modelType: T.Type
    ) throws -> T
    
    func parseResponseWithCustomParser<T: ParsableResponseModel>(
        data: Data,
        modelType: T.Type
    ) throws -> T
    
}
