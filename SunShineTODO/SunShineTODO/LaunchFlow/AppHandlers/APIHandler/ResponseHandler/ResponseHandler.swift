//
//  ResponseHandler.swift
//  Kado
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation


class ResponseHandler : ResponseHandlerType{
    
    func parseResponseWithJSONDecoder<T : CodableResponseModel>(
        data: Data,
        modelType: T.Type
    ) throws -> T {
        
        do {
            let decodedModel = try JSONDecoder().decode(modelType, from: data)
            return decodedModel
        } catch let error{
            Logger.logMessage(error)
            throw ResponseHandlerError.responseTypeIsNotInCodableFormat
        }
        
    }
    
    func parseResponseWithCustomParser<T : ParsableResponseModel>(
        data: Data,
        modelType: T.Type
    ) throws -> T {
        
        guard let json = data.toJSON() else {
            throw ResponseHandlerError.responseTypeIsNotInJSONFormat
        }
        
        guard let parsedData = T.parseData(from: json) else {
            throw ResponseHandlerError.responseTypeIsNotInCodableFormat
        }
        
        return parsedData
    }
    
}
