//
//  PlaceholderHandlerTextView.swift
//  Kado
//
//  Created by Suraj kahar on 26/03/25.
//

import UIKit

class PlaceholderHandlerTextView : UITextView, UITextViewDelegate {
    
    var placeHolder : String = ""
    var placeHolderColor: UIColor = .gray
    var textViewColor: UIColor = .black
    
    var textViewDidChange : ( (_ textView: UITextView) -> Void )?
    var textViewDidBeginEditing : ( (_ textView: UITextView) -> Void )?
    var textViewDidEndEditing : ( (_ textView: UITextView) -> Void )?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureTextView(
        placeHolder : String = "",
        placeHolderColor: UIColor = .gray,
        textViewColor: UIColor = .black
        
    ){
        self.addKeyboardDismissAbilityOnToolBarDoneButton()
        self.placeHolder = placeHolder
        self.placeHolderColor = placeHolderColor
        self.textViewColor = textViewColor
        self.setPlaceholder()
        
        delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewDidChange?(textView)
    }
    
    // Reset placeholder text when editing begins
    func textViewDidBeginEditing(_ textView: UITextView) {
        if text != "" && text == placeHolder{
            text = ""
            textColor = textViewColor
        }
        textViewDidBeginEditing?(textView)
    }
    
    // Restore placeholder text when editing ends
    func textViewDidEndEditing(_ textView: UITextView) {
        text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if textView.text == ""{
            setPlaceholder()
        }
        textViewDidEndEditing?(textView)
    }
    
    func setPlaceholder(){
        text = placeHolder
        textColor = placeHolderColor
    }
    
    func setText(text : String){
        if text == ""{
            setPlaceholder()
        }else{        
            self.text = text
            textColor = textViewColor
        }
    }
    
    func getText() -> String? {
        if text == placeHolder {
            return nil
        } else {
            return text
        }
    }
    
}
