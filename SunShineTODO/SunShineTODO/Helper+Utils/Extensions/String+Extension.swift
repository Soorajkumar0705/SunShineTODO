//
//  Extension+String.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import UIKit

extension String{
    
    func isValidEmail() -> Bool {
        
        // Regular expression for a simple email validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: self.trimmingCharacters(in: .whitespacesAndNewlines))
        
    }
    
    func isValidPhoneNumber() -> Bool {
        return self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil && self.count == 10
    }
    
    func isContainsNumberOnly() -> Bool {
        let regex = "^[0-9]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isUppercaseIncluded() -> Bool {
        return self.rangeOfCharacter(from: .uppercaseLetters) != nil
    }
    
    func isLowercaseIncluded() -> Bool {
        return self.rangeOfCharacter(from: .lowercaseLetters) != nil
    }
    
    func isDigitIncluded() -> Bool {
        return self.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    func isSpecialCharacterIncluded() -> Bool {
        
        let validCharacterSet = CharacterSet(charactersIn: "@$!%*?&#")
        let invalidCharacterSet = CharacterSet(charactersIn: "^()-_=+[]{}|;:'\"~,.<>/")
        
        if (self.rangeOfCharacter(from: validCharacterSet) == nil) || (self.rangeOfCharacter(from: invalidCharacterSet) != nil) {
            return false
        }
        
        return true
        
    }
    
    func isValidInputString() -> Bool{
        
        if self == ""{
            return true
        }
        
        let allowedCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!\"#$%&'()*+,-./:;<=>?@[]^_`{|}~©®™§°±×÷←↑→↓↵¢£¥€$"
        
        let characterSet = CharacterSet(charactersIn: allowedCharacters)
        
        if self.rangeOfCharacter(from: characterSet) == nil {
            return false
        }
        
        let pattern = "\\p{So}"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let matches = regex?.matches(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count))
        
        return (matches?.isEmpty ?? false)
    }
    
    func underline() -> NSAttributedString{
        let attributedString = NSAttributedString(
            string: self,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )
        return attributedString
    }
    
}

extension String{

    func toInt() -> Int?{
        return Int(self)
    }
    
    func toDouble() -> Double?{
        return Double(self)
    }
    
}

extension String {
    
    func toRoundedIntegerNearestOrAwayFromZero() -> Double{
        (Double(self) ?? 0.0).rounded(.toNearestOrAwayFromZero)
    }
}

extension String.SubSequence{
    
    func toString() -> String{
        return String(self)
    }
}

extension String {
    
    func toAttributedString() -> NSAttributedString{
        NSAttributedString(string: self)
    }
    
}

extension String{
    func htmlToAttributedString(font : UIFont, foregroundColor: UIColor) -> NSAttributedString?{
        guard let data = data(using: .utf8) else { return nil }
        do{
            let attrstring = try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
            let mutableAttrString = NSMutableAttributedString(attributedString: attrstring)
            mutableAttrString.addAttribute(.font, value: font, range: NSRange(location: 0, length: mutableAttrString.length))
            // Apply foreground color attribute
            mutableAttrString.addAttribute(.foregroundColor, value: foregroundColor, range: NSRange(location: 0, length: mutableAttrString.length))
            return mutableAttrString
        }catch let error{
            print("Error found :- ",error)
            return nil
        }
    }
}
