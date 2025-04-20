//
//  APIEndpointType.swift
//  Kado
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation

protocol HTTPMethodType {
    var rawValue: String { get }
}


protocol HTTPParamType {
    
}

protocol JsonRequestBodyType: Encodable, HTTPParamType {
    func toJson() -> StringAnyDict
}


protocol MultiPartRequestBodyType: Encodable, HTTPParamType {
    var boundary: String { get }
    func buildMultiPartBodyBuilder() -> MultipartFormDataBodyBuilder
}

extension Data : HTTPParamType { }


protocol APIEndpointType {
    
    var baseURL: String { get }
    var versionURL: String { get }
    var path: String { get }
    var method: HTTPMethodType { get }
    var headers : [HTTPHeader] { get }
    var params : HTTPParamRequestBody? { get }
    
}


protocol APIEndpointEnumType {
    
    var baseURL : String { get } // provide default base URL
    var versionURL : String { get } // provide default version URL
    
    func getEndpoint() -> APIEndpointType
    
    func getSessionTokenHeader() -> HTTPHeader
    func getHeadersForMultipart(paramBody : HTTPParamType) -> HTTPHeader
}

extension APIEndpointEnumType {
    
    var baseURL: String {
        APISourceURL
    }
    
    var versionURL: String {
        "api/v1/"
    }
    
}

extension APIEndpointEnumType {
    
    // SOME DEFAULT HEADERS
    
    var headers_wildCard : HTTPHeader {
        HTTPHeader(
            httpFieldName: HTTPHeaderField.accept.rawValue,
            value: HTTPHeaderFieldValue.wildCard.rawValue
        )
    }
    
    var headers_applicationJson : HTTPHeader {
        HTTPHeader(
            httpFieldName: HTTPHeaderField.contentType.rawValue,
            value: HTTPHeaderFieldValue.applicationJson.rawValue
        )
    }
    
    var defaultHeader : [HTTPHeader] {
        [
            headers_wildCard,
            headers_applicationJson
        ]
    }
    
    
    func getSessionTokenHeader() -> HTTPHeader {
        let fieldName = "x-session-token"
        let value = AuthenticationHandler.shared.sessionToken
        
        return HTTPHeader(httpFieldName: fieldName, value: value)
    }
    
    func getHeadersForMultipart(paramBody : HTTPParamType) -> HTTPHeader {
        guard let paramBody = paramBody as? MultiPartRequestBodyType else {
            return headers_applicationJson
        }
        return HTTPHeader(
            httpFieldName: HTTPHeaderField.contentType.rawValue,
            value: HTTPHeaderFieldValue.getMultiPartFormDataHeaderValue(boundary: paramBody.boundary)
        )
    }
    
}
