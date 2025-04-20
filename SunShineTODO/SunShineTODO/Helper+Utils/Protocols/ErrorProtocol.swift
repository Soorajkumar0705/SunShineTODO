//
//  ErrorProtocol.swift
//  Kado
//
//  Created by Suraj kahar on 13/03/25.
//

import Foundation

protocol ErrorProtocol : Error{
    
    // Provide an error message
    var errorDescription: String? { get }
    
    // Provide suggestions on how to fix the error
    var recoverySuggestion: String? { get }
    
    
}
