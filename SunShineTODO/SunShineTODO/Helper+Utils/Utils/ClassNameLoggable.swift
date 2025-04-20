//
//  ClassNameLoggable.swift
//  Kado
//
//  Created by Suraj kahar on 28/02/25.
//

import UIKit


protocol ClassNameLoggable {
    
    var className: String { get }
    static var className : String { get }
    
}

extension ClassNameLoggable {
    
    var className: String {
        String(describing: type(of: self))
    }
    
    static var className : String {
        String(describing: self)
    }
    
}


extension NSObject : ClassNameLoggable{ }

