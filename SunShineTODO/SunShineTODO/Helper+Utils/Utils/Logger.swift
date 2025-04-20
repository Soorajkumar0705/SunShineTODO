//
//  Logger.swift
//  Kado
//
//  Created by Suraj kahar on 27/02/25.
//

import Foundation

class Logger {
    
    static func logMessage(_ messageText: String) {
#if DEBUG
        print(messageText)
#else
        NSLog(messageText)
#endif
    }
    
    static func logMessage(_ message: Any) {
#if DEBUG
        print(message)
#else
        // WILL DO SOMETHING OF THIS BLOCK 
#endif
    }
    
    
}
