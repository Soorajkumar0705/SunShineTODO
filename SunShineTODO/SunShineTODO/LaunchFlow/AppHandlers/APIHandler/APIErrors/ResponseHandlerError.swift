//
//  ResponseHandlerError.swift
//  Kado
//
//  Created by Suraj kahar on 10/02/25.
//

import Foundation


enum ResponseHandlerError: ErrorProtocol, ClassNameLoggable, LocalizedError {
    
    case responseTypeIsNotInCodableFormat
    case responseTypeIsNotInJSONFormat
    case responseTypeNotConfirmsToAnyParsableFormat
    case responseTypeNotConfirmsToParsableResponseModel
    case unwantedMemoryDeallocation
    
    var errorDescription: String? {
        className + " :- " + {
            return switch self {
            case .responseTypeIsNotInCodableFormat:
                "The response type is not in a codable format."
            case .responseTypeIsNotInJSONFormat:
                "The response type is not in JSON format."
            case .responseTypeNotConfirmsToAnyParsableFormat:
                "The response type does not conform to any parsable format."
            case .responseTypeNotConfirmsToParsableResponseModel:
                "The response type does not conform to a parsable response model."
            case .unwantedMemoryDeallocation:
                "Unexpected memory deallocation occurred."
            }
        }()
    }
    
    var recoverySuggestion: String? {
        {
            return switch self {
            case .responseTypeIsNotInCodableFormat:
                "Check the response model and ensure it conforms to the Codable protocol."
            case .responseTypeIsNotInJSONFormat:
                "Verify that the response data is properly formatted as JSON."
            case .responseTypeNotConfirmsToAnyParsableFormat:
                "Check the response format and ensure it matches the expected parsing format."
            case .responseTypeNotConfirmsToParsableResponseModel:
                "Make sure the response model conforms to the expected response structure."
            case .unwantedMemoryDeallocation:
                "Inspect memory management practices and retain cycles to avoid unexpected deallocation."
            }
        }()
    }
}
