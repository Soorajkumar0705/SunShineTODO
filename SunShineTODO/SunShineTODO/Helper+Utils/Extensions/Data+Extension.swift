//
//  Data+Extension.swift
//  Kado
//
//  Created by Suraj kahar on 11/02/25.
//

import UIKit

extension Data{
    
    func toImage() -> UIImage{
        return UIImage(data: self) ?? UIImage(named: "") ?? UIImage()
    }
    
    func toString(encoding : String.Encoding = .utf8) -> String?{
        String(data: self, encoding: encoding)?.replacingOccurrences(of: "\0", with: "")
    }
    
}
