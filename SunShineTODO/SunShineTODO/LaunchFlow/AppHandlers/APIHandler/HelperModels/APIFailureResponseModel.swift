//
//  APIFailureResponseModel.swift
//  Kado
//
//  Created by Suraj kahar on 09/01/25.
//

import Foundation

struct APIFailureResponseModel : CodableResponseModel{
    
    var isError : Bool?
    var message: String?
    var errors: [String: [String]]?
    
    enum CodingKeys : String, CodingKey{
        case isError = "is_error"
        case message
        case errors
    }
    
    func parseFieldValidationError<T: APIFieldValidationErrorCodableType>(fieldErrorType: T.Type) -> T? {
        
        if fieldErrorType is (any APIFieldValidationErrorParsableType.Type) {
            
            guard let modelType = fieldErrorType as? (any ParsableResponseModel.Type),
                  let decodedError = modelType.parseData(from: errors as Any) as? T
            else{
                return nil
            }
            
            return decodedError
            
        }else {
            
            guard let errors,
                  let errorData = try? JSONSerialization.data(withJSONObject: errors, options: []),
                  let decodedError = try? JSONDecoder().decode(T.self, from: errorData)
            else {
                return nil
            }
            return decodedError
            
        }
        
    }
}
