//
//  RequestFactory.swift
//  Kado
//
//  Created by Suraj kahar on 22/01/25.
//

import Foundation


class RequestFactory : RequestFactoryType{
    
    func getRequest(for endpoint : APIEndpointType) throws -> URLRequest {
        
        let urlString = endpoint.baseURL + endpoint.versionURL + endpoint.path
        
        guard let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedString)
        else {
            throw NetworkHandlerError.invalidUrl
        }
        
        print("URL : ", url.absoluteString)
        
        var request = URLRequest(url: url)
        
        if let params = endpoint.params{
            try handleParamBody(request: &request, params: params)
        }
        
        
        request.httpMethod = endpoint.method.rawValue
        
        // SET HEADERS
        
        for header in (endpoint.headers) {
            request.addValue(header.value, forHTTPHeaderField: header.httpFieldName)
        }
        
        print("URL Request Headers : ", request.allHTTPHeaderFields ?? [:] )
        
        return request
    }
    
    
    private func handleParamBody(request : inout URLRequest, params : HTTPParamRequestBody) throws {
        
        if let cachePolicy = params.cachePolicy { request.cachePolicy = cachePolicy }
        request.timeoutInterval = params.timeoutInterval ?? 30
        
        switch params.body {
            
        case let body as MultiPartRequestBodyType:
            request.httpBody = body.buildMultiPartBodyBuilder().build()
            
        case let params as JsonRequestBodyType:
            guard let httpBody = try? JSONSerialization.data(
                withJSONObject: params.toJson(),
                options: [] ) else {
                throw NetworkHandlerError.invalidParameters
            }
            
            request.httpBody = httpBody
            
            print("URL Request : ", params.toJson())
            
        case let body as Data:
            request.httpBody = body
            
        default:
            break;
            
        }
    } // func handleParamBody(request : inout URLRequest, params : HTTPParam)
    
}
