//
//  Enum.swift
//  Kado
//
//  Created by Suraj kahar on 03/01/25.
//

import Foundation


enum HTTPMethod : HTTPMethodType {
    
    case GET
    case POST
    case DELETE
    
    
    var rawValue: String {
        switch self {
        case .GET: return "GET"
        case .POST: return "POST"
        case .DELETE: return "DELETE"
        }
    }
    
}   // enum HTTPMethod : String
