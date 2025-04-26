//
//  OtherExtensions.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import UIKit


extension Int {

    func toDouble() -> Double{
        Double(self)
    }
    
    func toString() -> String{
        String(self)
    }
    
    func isTrue() -> Bool {
        self != 0
    }
    
}


extension Double{
    
    func toInt() -> Int{
        return Int(self)
    }
}


extension UIColor {
    
    func colorAlpha(_ alpha : CGFloat) -> UIColor {
        self.withAlphaComponent(alpha)
    }
    
}
