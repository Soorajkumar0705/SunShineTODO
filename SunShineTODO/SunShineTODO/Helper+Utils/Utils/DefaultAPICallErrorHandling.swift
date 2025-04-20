//
//  DefaultAPICallErrorHandling.swift
//  Kado
//
//  Created by Suraj kahar on 19/03/25.
//

import Foundation

class DefaultAPICallErrorHandling {
    
    static var defaultErrorMessage = "Something went wrong! Please try again later."
    
    
    static func retrieveErrorMessage(_ error: Error) -> String {
        
        switch error {
            
        case let error as NetworkAPIResponseError:
            switch error {
                
            case .errorInApiResponse(errorData: _ , errorJSON: let errorJSON, statusCode: _):
                let res = CommonAPIRes.parseData(from: errorJSON as Any)
                return res?.message ?? defaultErrorMessage
                
            default:
                return error.recoverySuggestion ?? defaultErrorMessage
            }
            
        default:
            return (error as? ErrorProtocol)?.recoverySuggestion ?? defaultErrorMessage            
        }
    }
    
    
}
