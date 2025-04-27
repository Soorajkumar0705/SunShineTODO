//
//  ViewClass.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import UIKit

// MARK: - Custom Classes

class TestLabel : UILabel{
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = FontFamily.kTest.ofSize(self.font.pointSize)
    }
}

//MARK: - Custom View
class CornerRadiusView: UIView{

    @IBInspectable private var cornerRadius: CGFloat = 0.0
    @IBInspectable private var isCapsuleCircle: Bool = false
    @IBInspectable private var isCylinderCircle: Bool = false
    @IBInspectable private var x0y0 : Bool = false
    @IBInspectable private var x1y0 : Bool = false
    @IBInspectable private var x1y1 : Bool = false
    @IBInspectable private var x0y1 : Bool = false
    
    private func applySpecificCornerRadius(){
        var corners: CACornerMask = []
        
        if x0y0{
            corners.insert(.layerMinXMinYCorner)
        }
        
        if x1y0{
            corners.insert(.layerMaxXMinYCorner)
        }
        
        if x1y1{
            corners.insert(.layerMaxXMaxYCorner)
        }
        
        if x0y1{
            corners.insert(.layerMinXMaxYCorner)
        }
        
        if corners.isEmpty{
            corners = [.layerMinXMinYCorner,
                       .layerMaxXMinYCorner,
                       .layerMaxXMaxYCorner,
                       .layerMinXMaxYCorner]
        }
        applyCornerRadius(cornerRadius: cornerRadius, corners: corners)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isCapsuleCircle{
            applyCornerRadius(cornerRadius: self.frame.height/2)
            
        }else if isCylinderCircle{
            applyCornerRadius(cornerRadius: self.frame.width/2)
            
        }else{
            self.applySpecificCornerRadius()
        }
    }
}

class CornerRadiusBorderView: CornerRadiusView{
    
    @IBInspectable private var borderWidth: CGFloat = 0.0
    @IBInspectable private var borderColor: UIColor = .clear
    @IBInspectable private var borderOpacity: CGFloat = 1.0

    override func awakeFromNib() {
        super.awakeFromNib()
        applyBorder(borderWidth: borderWidth, borderColor: borderColor, borderOpacity: borderOpacity)
    }
    
}

class CornerRadiusBorderShadowView: CornerRadiusBorderView{
    
    @IBInspectable private var shadowColor: UIColor = .clear
    @IBInspectable private var shadowOpacity: Float = 1.0
    @IBInspectable private var shadowXOffset: CGFloat = 0
    @IBInspectable private var shadowYOffset: CGFloat = 0
    @IBInspectable private var shadowBlur: CGFloat = 0
    @IBInspectable private var shadowSpread: CGFloat = 0
   
    override func layoutSubviews() {
        super.layoutSubviews()
        applyShadow(shadowColor: shadowColor, shadowOpacity: shadowOpacity, shadowXOffset: shadowXOffset, shadowYOffset: shadowYOffset, shadowBlur: shadowBlur, shadowSpread: shadowSpread)
    }
    
}



//MARK: - Custom UIButton

class CornerRadiusButton: UIButton{
    
    @IBInspectable private var cornerRadius: CGFloat = 0.0
    @IBInspectable private var isCapsuleCircle: Bool = false
    @IBInspectable private var isCylinderCircle: Bool = false
    @IBInspectable private var x0y0 : Bool = false
    @IBInspectable private var x1y0 : Bool = false
    @IBInspectable private var x1y1 : Bool = false
    @IBInspectable private var x0y1 : Bool = false
    
    private func applySpecificCornerRadius(){
        var corners: CACornerMask = []
        
        if x0y0{
            corners.insert(.layerMinXMinYCorner)
        }
        
        if x1y0{
            corners.insert(.layerMaxXMinYCorner)
        }
        
        if x1y1{
            corners.insert(.layerMaxXMaxYCorner)
        }
        
        if x0y1{
            corners.insert(.layerMinXMaxYCorner)
        }
        
        if corners.isEmpty{
            corners = [.layerMinXMinYCorner,
                       .layerMaxXMinYCorner,
                       .layerMaxXMaxYCorner,
                       .layerMinXMaxYCorner]
        }
        applyCornerRadius(cornerRadius: cornerRadius, corners: corners)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isCapsuleCircle{
            applyCornerRadius(cornerRadius: self.frame.height/2)
            
        }else if isCylinderCircle{
            applyCornerRadius(cornerRadius: self.frame.width/2)
            
        }else{
            self.applySpecificCornerRadius()
        }
    }
}

class CornerRadiusBorderButton: CornerRadiusButton{

    @IBInspectable private var borderWidth: CGFloat = 0.0
    @IBInspectable private var borderColor: UIColor = .clear
    @IBInspectable private var borderOpacity: CGFloat = 1.0

    override func awakeFromNib() {
        super.awakeFromNib()
        applyBorder(borderWidth: borderWidth, borderColor: borderColor, borderOpacity: borderOpacity)
    }

}

class CornerRadiusBorderShadowButton: CornerRadiusBorderButton{

    @IBInspectable private var shadowColor: UIColor = .clear
    @IBInspectable private var shadowOpacity: Float = 1.0
    @IBInspectable private var shadowXOffset: CGFloat = 0
    @IBInspectable private var shadowYOffset: CGFloat = 0
    @IBInspectable private var shadowBlur: CGFloat = 0
    @IBInspectable private var shadowSpread: CGFloat = 0

    override func layoutSubviews() {
        super.layoutSubviews()
        applyShadow(shadowColor: shadowColor, shadowOpacity: shadowOpacity, shadowXOffset: shadowXOffset, shadowYOffset: shadowYOffset, shadowBlur: shadowBlur, shadowSpread: shadowSpread)
    }

}

// For the custom Gradient
//@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   1 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    @IBInspectable var cornerRadius:CGFloat = 0.0 { didSet{ updatePoints() }}
    @IBInspectable var isCircle:Bool = false { didSet{ updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    func updateRadius() {
        layer.cornerRadius = isCircle ? (bounds.height / 2) : cornerRadius
    }
    override public func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
        updateRadius()
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
        updateRadius()
    }

}
