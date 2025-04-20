//
//  APIService.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import Foundation


//MARK: - APIService

class APIService : NSObject, APIServiceProtocol{
    
    var networkHandler: any NetworkHandlerType
    var responseHandler: any ResponseHandlerType
    
    
    init(networkHandler : NetworkHandlerType,
         responseHandler : ResponseHandlerType
    ){
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    
    func getData< S : CodableResponseModel >(
        endpoint : APIEndpointEnumType,
        useCustomParser : Bool = false,
        successResponseModelType : S.Type
        
    ) async throws -> S {
        
        do{
            let networkResult = try await networkHandler.requestDataAPI(endpoint: endpoint.getEndpoint())
            
            if useCustomParser,
               let successResponseModelType = successResponseModelType.self as? (any ParsableResponseModel.Type) {
                
                return try responseHandler.parseResponseWithCustomParser(data: networkResult, modelType: successResponseModelType) as! S
            }else{
                
                return try responseHandler.parseResponseWithJSONDecoder(data: networkResult, modelType: successResponseModelType)
                
            }

        }catch let error {
            
            if let networkApiError = error as? NetworkAPIResponseError {
                
                switch networkApiError {
                    
                case .errorInApiResponse(errorData: _, errorJSON: _, statusCode: let statusCode):
                    // IF UNAUTHORISED THEN START THE LOGIN FLOW
                    if statusCode == 401 {
                        
                        DispatchQueue.main.async {
                            Toast.show("Session expired. Please login and try again.")
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
                            AuthenticationHandler.shared.removeAuthenticationDetails()
//                            .makeVC().rootVC()
                            
                        })
                    }
                default: break
                }
            }
            
            throw error
        }
        
    }   // func getData<T:ParsableResponseModel>(endpoint : AuthenticationEndPoint
    
}

