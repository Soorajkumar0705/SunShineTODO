//
//  UITextView+Extension.swift
//  Kado
//
//  Created by Suraj kahar on 12/03/25.
//

import UIKit


extension UITextView {
    
    // Store the height constraint as an associated object
    private static var heightConstraintKey: UInt8 = 0
    
    // Store the mX height as an associated object
    private static var maxHeightKey: UInt8 = 0
    
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return objc_getAssociatedObject(self, &Self.heightConstraintKey) as? NSLayoutConstraint
        }
        set {
            objc_setAssociatedObject(self, &Self.heightConstraintKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var maxHeight: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &Self.maxHeightKey) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &Self.maxHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addHeightUpdatingObserver(_ maxHeight : CGFloat? = nil){
        self.maxHeight = maxHeight
        self.addObserver(self, forKeyPath: "contentSize",options: .new  ,context: nil)
        heightConstraint = heightAnchor.constraint(equalToConstant: 10)
        heightConstraint!.priority = UILayoutPriority(900)
        heightConstraint!.isActive = true
    }
    
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard (keyPath == "contentSize"),
              let newValue = change?[.newKey] as? CGSize,
              (object as? UITextView) == self
        else {
            return
        }
        
        if let maxHeight, newValue.height >= maxHeight {
            heightConstraint?.constant = maxHeight
            
        }else{
            heightConstraint?.constant = newValue.height
        }
        
    }
    
}
