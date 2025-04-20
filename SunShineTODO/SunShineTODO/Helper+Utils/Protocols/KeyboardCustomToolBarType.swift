//
//  KeyboardCustomToolBarType.swift
//  Kado
//
//  Created by Suraj kahar on 06/03/25.
//

import UIKit

protocol KeyboardCustomToolBarType : UITextInput{
    
    var inputAccessoryView : UIView? { get set }
    
    func addKeyboardDismissAbilityOnToolBarDoneButton()
    func addDoneButtonInToolBarKeyboard(action : UIAction)
}

extension KeyboardCustomToolBarType where Self : UIResponder{
    
    func addKeyboardDismissAbilityOnToolBarDoneButton(){
        let action = UIAction { [weak self] _ in
            print("Action bar tapped..")
            self?.resignFirstResponder()
        }
        addDoneButtonToolBar(toolBarAction: action)
    }
    
    func addDoneButtonInToolBarKeyboard( action : UIAction) {
        addDoneButtonToolBar(toolBarAction: action)
    }
    
    private func addDoneButtonToolBar(toolBarAction: UIAction){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        // Use a wrapper to store the UIAction
        let actionWrapper = UIBarButtonItem.ActionWrapper(action: toolBarAction)
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: actionWrapper, action: #selector(actionWrapper.invoke(_:)))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        // Store the wrapper so it's not deallocated
        objc_setAssociatedObject(self, AssociatedKeys.actionWrapper, actionWrapper, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.inputAccessoryView = doneToolbar
    }
    
}


// Helper Wrapper to handle UIAction execution
private extension UIBarButtonItem {
    class ActionWrapper {
        let action: UIAction
        
        init(action: UIAction) {
            self.action = action
        }
        
        @objc func invoke(_ sender: UIBarButtonItem) {
            print("Action bar tapped in wrapper.")
            action.performWithSender(sender, target: nil)
        }
    }
}

// Prevents wrapper from being deallocated
private struct AssociatedKeys {
    static var actionWrapper = "actionWrapper"
}


extension UITextView : KeyboardCustomToolBarType  { }
extension UITextField : KeyboardCustomToolBarType  { }
