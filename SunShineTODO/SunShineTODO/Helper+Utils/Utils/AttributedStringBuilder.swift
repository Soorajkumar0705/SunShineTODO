//
//  AttributedStringBuilder.swift
//  Kado
//
//  Created by Suraj kahar on 14/03/25.
//

import UIKit

class AttributedStringBuilder {
    
    var text : String
    
    init(_ text : String){
        self.text = text
    }
    
    var attributes: [NSAttributedString.Key : Any] = [:]
    
    var font : UIFont?
    var textColor : UIColor?
    var backgroundColor : UIColor?
    
    var underLineStyle: NSUnderlineStyle?
    var underLineColor: UIColor?
    
    
    func setFont(_ font : UIFont) -> Self{
        self.font = font
        return self
    }
    
    func setTextColor(_ textColor : UIColor) -> Self{
        self.textColor = textColor
        return self
    }
    
    func setBackgroundColor(_ backgroundColor : UIColor) -> Self{
        self.backgroundColor = backgroundColor
        return self
    }
    
    
    
    func setUnderLineStyle(_ style : NSUnderlineStyle) -> Self{
        self.underLineStyle = style
        return self
    }
    
    func setUnderLineColor(_ color : UIColor) -> Self{
        self.underLineColor = color
        return self
    }
    
    func applyAdditionalCustomAttributes(_ customAttributes : [NSAttributedString.Key : Any]) -> Self{
        self.attributes.merge(customAttributes) { (_, new) in new }
        return self
    }
    
    
    func build() -> AttributedString{

        if let font {
            attributes[.font] = font
        }
        if let textColor {
            attributes[.foregroundColor] = textColor
        }
        if let backgroundColor {
            attributes[.backgroundColor] = backgroundColor
        }
        
        
        if let underLineStyle {
            attributes[.underlineStyle] = NSNumber(value: underLineStyle.rawValue)
        }
        if let underLineColor {
            attributes[.underlineColor] = underLineColor
        }
        
        return AttributedString(text, attributes: AttributeContainer(attributes))
    }
    

}

