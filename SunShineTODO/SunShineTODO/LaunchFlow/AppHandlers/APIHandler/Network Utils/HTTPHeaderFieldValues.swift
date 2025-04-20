//
//  HTTPHeaderValues.swift
//  Kado
//
//  Created by Suraj kahar on 20/01/25.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case accept = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
    case connection = "Connection"
}

enum HTTPHeaderFieldValue: String {
    case applicationJson = "application/json"
    case applicationFormUrlencoded = "application/x-www-form-urlencoded"
    case multipartFormData = "multipart/form-data"
    case textPlain = "text/plain"
    case applicationXML = "application/xml"
    case applicationQuery = "application/query"
    case wildCard = "*/*"
    
    static func getMultiPartFormDataHeaderValue(boundary : String) -> String {
        "multipart/form-data; boundary=\(boundary)"
    }
}
