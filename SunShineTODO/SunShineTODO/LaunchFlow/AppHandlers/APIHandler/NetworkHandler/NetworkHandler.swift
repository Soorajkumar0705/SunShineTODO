//
//  NetworkHandler.swift
//  Kado
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation


class NetworkHandler : NetworkHandlerType {
    
    var requestFactory: any RequestFactoryType
    
    init(
        requestFactory: any RequestFactoryType
    ){
        self.requestFactory = requestFactory
    }

    func requestDataAPI(
        endpoint : APIEndpointType
        
    )  async throws -> Data {
        
        if NetworkReachability.shared.isNetworkAvailable() == false {
            throw NetworkHandlerError.noInternetConnection
        }
        
        let req = try requestFactory.getRequest(for: endpoint)
        
        let (data, httpResponse) = try await URLSession.shared.data(for: req)
        
        
        print("URL : ", req.url?.absoluteString as Any)
        print("URL Response : ", data.toJSON() as Any)
        
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw NetworkHandlerError.unknownHTTPResponseFormat
        }
        
        if (200...300).contains(httpResponse.statusCode){
            
            return data
        }else{
            
            if let json = data.toJSON() {
                
                throw NetworkAPIResponseError.errorInApiResponse(errorData: data, errorJSON: json, statusCode: httpResponse.statusCode)
                
            }else{
                throw NetworkAPIResponseError.providedAPIErrorIsNotInJSONFormat(errorData: data, statusCode: httpResponse.statusCode)
            }
            
        }

    }

}
