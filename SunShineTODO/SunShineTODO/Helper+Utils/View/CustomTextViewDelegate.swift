//
//  CustomTextViewDelegate.swift
//  Kado
//
//  Created by Harsh on 13/03/25.
//

import Foundation
import UIKit

class CustomTextViewDelegate: NSObject, UITextViewDelegate {
    
    var textView : UITextView
    var placeHolder : String
    var placeHolderColor: UIColor
    var textViewColor: UIColor
    
    var textViewDidChange : ( (_ textView: UITextView) -> Void )?
    var textViewDidBeginEditing : ( (_ textView: UITextView) -> Void )?
    var textViewDidEndEditing : ( (_ textView: UITextView) -> Void )?
    
    
    init(textView : UITextView, placeHolder: String, placeHolderColor: UIColor, textViewColor : UIColor) {
        self.placeHolder = placeHolder
        self.placeHolderColor = placeHolderColor
        self.textViewColor = textViewColor
        self.textView = textView
        super.init()
        self.textView.text = placeHolder
        self.textView.textColor = placeHolderColor
    }
    
    // Adjust text view height as text changes
    func textViewDidChange(_ textView: UITextView) {
//        let size = CGSize(width: textView.frame.width, height: .infinity)
//        let estimatedSize = textView.sizeThatFits(size)
//        
//        // Update height constraint of text view if needed
//        textView.constraints.forEach { [weak self] constraint in
//            guard let _ = self else { return }
//            if constraint.firstAttribute == .height {
//                if estimatedSize.height > textView.frame.height {
//                    constraint.constant = estimatedSize.height
//                }
//            }
//        }
        textViewDidChange?(textView)
    }
    
    // Reset placeholder text when editing begins
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text != "" && textView.text == placeHolder{
            textView.text = ""
            textView.textColor = textViewColor
        }
        textViewDidBeginEditing?(textView)
    }
    
    // Restore placeholder text when editing ends
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if textView.text == ""{
            setPlaceholder()
        }
        textViewDidEndEditing?(textView)
    }
    
    func setPlaceholder(){
        textView.text = placeHolder
        textView.textColor = placeHolderColor
    }
    
    func setText(text : String){
        textView.text = text
        textView.textColor = textViewColor
    }
    
    func getText() -> String? {
        if textView.text == placeHolder {
            return nil
        } else {
            return textView.text
        }
    }
    
}
