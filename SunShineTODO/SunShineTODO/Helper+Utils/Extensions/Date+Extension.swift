//
//  Extension+Date.swift
//  Kado
//
//  Created by Suraj kahar on 01/01/25.
//

import Foundation



extension String{
    
    func getUTCDate() -> Date?{
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.locale = .current
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.date(from: self)
    }
    
}


extension Date {
    
    func getFormattedDate(format: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.timeZone = .current
        dateFormat.dateFormat = format
        return dateFormat.string(from: self)
     }
    
}
