//
//  NetworkHandlerError.swift
//  Kado
//
//  Created by Suraj kahar on 10/02/25.
//

import Foundation


enum NetworkHandlerError: ErrorProtocol, ClassNameLoggable, LocalizedError {
    
    case noInternetConnection
    case invalidUrl
    case invalidParameters
    case errorWhileInitiatingRequest
    case errorInAPIRequest
    case unknownHTTPResponseFormat
    case unKnownError
    
    var errorDescription: String? {
        className + " :- " + {
            return switch self {
            case .noInternetConnection:
                "No internet connection. Please check your network settings."
            case .invalidUrl:
                "Invalid URL. Please contact support."
            case .invalidParameters:
                "Invalid parameters were provided."
            case .errorWhileInitiatingRequest:
                "Error while initiating the request."
            case .errorInAPIRequest:
                "Error in API response."
            case .unknownHTTPResponseFormat:
                "The server response format is unknown."
            case .unKnownError:
                "An unknown error occurred."
            }
        }()
    }
    
    var recoverySuggestion: String? {
        {
            return switch self {
            case .noInternetConnection:
                "Try reconnecting to Wi-Fi or cellular data and retry the request."
            case .invalidUrl:
                "Check the URL or contact support for assistance."
            case .invalidParameters:
                "Verify the input parameters and try again."
            case .errorWhileInitiatingRequest:
                "Restart the app and try initiating the request again."
            case .errorInAPIRequest:
                "Error While connecting to the server, Please try again."
            case .unknownHTTPResponseFormat:
                "Contact support with the response details."
            case .unKnownError:
                "Restart the app or contact support for assistance."
            }
        }()
    }
}


enum NetworkAPIResponseError: ErrorProtocol, ClassNameLoggable, LocalizedError {
    
    case providedAPIErrorIsNotInJSONFormat(errorData: Data?, statusCode: Int)
    case errorInApiResponse(errorData: Data?, errorJSON: StringAnyDict?, statusCode: Int)
    case errorInApiResponseFromServer(errorMessage: String?)
    
    var errorDescription: String? {
        className + " :- " + {
            return switch self {
            case .providedAPIErrorIsNotInJSONFormat(_, let statusCode):
                "API responded with an error which is not in JSON format. Status code: \(statusCode)."
            case .errorInApiResponse(_, _, let statusCode):
                "API responded with an error. Status code: \(statusCode)."
                
            case .errorInApiResponseFromServer(errorMessage: let errorMessage):
                "Error : \(errorMessage ?? "Internal Error found")."
                
            }
        }()
    }
    
    var recoverySuggestion: String? {
        {
            return switch self {
            case .providedAPIErrorIsNotInJSONFormat(_, _):
                "Please Try again. Contact support if the problem continues."
            case .errorInApiResponse(_, _, _):
                "Please Try again. Contact support if the problem continues."
                
            case .errorInApiResponseFromServer(errorMessage: _/*let errorMessage*/):
                "Please Try again. Contact support if the problem continues."
            }
        }()
    }
    
}

