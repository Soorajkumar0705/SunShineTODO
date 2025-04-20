//
//  APIEndpoint.swift
//  Kado
//
//  Created by Suraj kahar on 10/02/25.
//


struct APIEndpoint : APIEndpointType{
    
    var baseURL: String
    var versionURL: String
    var path: String
    var method: (any HTTPMethodType)
    var headers : [HTTPHeader]
    var params: HTTPParamRequestBody?
    
}
