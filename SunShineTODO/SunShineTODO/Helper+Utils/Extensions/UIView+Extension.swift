//
//  Extension+UIView.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import UIKit


extension UIView{
    
    func circularShape(){
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func applyCornerRadius(cornerRadius: CGFloat, corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]){
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = corners
    }
    
    func applyBorder(borderWidth: CGFloat, borderColor: UIColor, borderOpacity: CGFloat = 1.0){
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.withAlphaComponent(borderOpacity).cgColor
        
    }
    
    // Function to apply shadow
    func applyShadow(shadowColor: UIColor, shadowOpacity: Float, shadowXOffset: CGFloat = 0, shadowYOffset: CGFloat = 0, shadowBlur: CGFloat, shadowSpread: CGFloat) {
        layer.masksToBounds = false  // Set to false to allow the shadow to be visible outside the corner radius
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowXOffset, height: shadowYOffset)
        layer.shadowRadius = shadowBlur / 2.0
        
        // Calculate the spread for the rounded path
        let spread = max(0, shadowSpread)
        
        // Set the shadow path to the rounded path with spread
        let roundedRect = bounds.insetBy(dx: -spread, dy: -spread)
        layer.shadowPath = UIBezierPath(roundedRect: roundedRect, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func applyShadowWithFalseMasking(
        shadowColor: UIColor,
        shadowOpacity: Float,
        shadowXOffset: CGFloat = 0,
        shadowYOffset: CGFloat = 0,
        shadowBlur: CGFloat,
        shadowSpread: CGFloat
    ) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: shadowXOffset, height: shadowYOffset)
        layer.shadowRadius = shadowBlur / 2.0

        let spread = max(0, shadowSpread)
        let shadowRect = bounds.insetBy(dx: -spread, dy: -spread)
        let adjustedCornerRadius = (bounds.width / 2) + spread // Match corner radius to circular shadow path

        layer.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: adjustedCornerRadius).cgPath
    }

}

// Tap Gesture
extension UIView{

    func addTapGesture(configGesture: (UITapGestureRecognizer) -> Void = { _ in }, action: @escaping (UITapGestureRecognizer) -> Void = { _ in }){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_ : )))
        configGesture(tapGesture)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)

        guard let key = AssociatedTapGestureActionKeys.singleTapAction else {
            fatalError("AssociatedTapGestureActionKeys.singleTapAction is nil.")
        }
        objc_setAssociatedObject(self, key, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer){
        guard let key = AssociatedTapGestureActionKeys.singleTapAction else {
            fatalError("AssociatedTapGestureActionKeys.singleTapAction is nil.")
        }
        if let action = objc_getAssociatedObject(self, key) as? (UITapGestureRecognizer) -> Void {
            action(gesture)
        }
        print("Tap")
    }

    private struct AssociatedTapGestureActionKeys{
        static let singleTapAction = UnsafeRawPointer(bitPattern: "singleTapAction".hashValue)
    }
    
}

// Swipe Gesture
extension UIView {

    func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction, configGesture: ((UISwipeGestureRecognizer) -> Void)? = nil, action: ((UISwipeGestureRecognizer) -> Void)? = nil) {

        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = direction
        configGesture?(swipeGesture)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(swipeGesture)

        // Store the action closure as an associated object based upon the swipe direction
        switch direction{

        case .up:
            guard let key = AssociatedSwipeGestureActionKeys.swipeUpAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeUpAction is nil.")
            }
            objc_setAssociatedObject(self, key, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            print("up")

        case .down:
            guard let key = AssociatedSwipeGestureActionKeys.swipeDownAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeDownAction is nil.")
            }
            objc_setAssociatedObject(self, key, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            print("down")

        case.left:
            guard let key = AssociatedSwipeGestureActionKeys.swipeLeftAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeLeftAction is nil.")
            }
            objc_setAssociatedObject(self, key, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            print("left")

        case .right:
            guard let key = AssociatedSwipeGestureActionKeys.swipeRightAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeRightAction is nil.")
            }
            objc_setAssociatedObject(self, key, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            print("Right")

        default:
            guard let key = AssociatedSwipeGestureActionKeys.swipeUnknownAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeUnknownAction is nil.")
            }
            objc_setAssociatedObject(self, key, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            print("unknown direction")
        }
    }

    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        var mainKey : UnsafeRawPointer!
        
        switch gesture.direction{

        case .up:
            guard let key = AssociatedSwipeGestureActionKeys.swipeUpAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeUpAction is nil.")
            }
            mainKey = key
            print("up")

        case .down:
            
            guard let key = AssociatedSwipeGestureActionKeys.swipeDownAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeDownAction is nil.")
            }
            mainKey = key
            print("down")

        case.left:
            
            guard let key = AssociatedSwipeGestureActionKeys.swipeLeftAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeLeftAction is nil.")
            }
            mainKey = key
            print("left")

        case .right:
            guard let key = AssociatedSwipeGestureActionKeys.swipeRightAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeRightAction is nil.")
            }
            mainKey = key
            print("Right")

        default:
            
            guard let key = AssociatedSwipeGestureActionKeys.swipeUnknownAction else {
                fatalError("AssociatedSwipeGestureActionKeys.swipeUnknownAction is nil.")
            }
            mainKey = key
            print("unknown direction")
        }
        
        if let action = objc_getAssociatedObject(self, mainKey) as? (UISwipeGestureRecognizer) -> Void {
            action(gesture)
        }
        
    }
    
    private struct AssociatedSwipeGestureActionKeys {
        static let swipeUpAction = UnsafeRawPointer(bitPattern: "swipeUpAction".hashValue)
        static let swipeDownAction = UnsafeRawPointer(bitPattern: "swipeDownAction".hashValue)
        static let swipeRightAction = UnsafeRawPointer(bitPattern: "swipeRightAction".hashValue)
        static let swipeLeftAction = UnsafeRawPointer(bitPattern: "swipeLeftAction".hashValue)
        static let swipeUnknownAction = UnsafeRawPointer(bitPattern: "swipeUnknownAction".hashValue)
    }
    
}

extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

extension UIScrollView {
    
    func addPullToRefresh(configControl: ((UIRefreshControl) -> Void)? = nil, action: ((UIRefreshControl) -> Void)? = nil){
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handlePullToRefresh(_:)), for: .valueChanged)
        configControl?(refreshControl)
        self.refreshControl = refreshControl
    
        guard let key = AssociatedPullToRefreshActionKeys.pullAction else {
            fatalError("AssociatedPullToRefreshActionKeys.pullAction is nil.")
        }
        objc_setAssociatedObject(self, key, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }

    @objc private func handlePullToRefresh(_ refreshControl: UIRefreshControl){
        guard let key = AssociatedPullToRefreshActionKeys.pullAction else {
            fatalError("AssociatedPullToRefreshActionKeys.pullAction is nil.")
        }
        guard let action = objc_getAssociatedObject(self, key) as? (UIRefreshControl) -> Void else {
            fatalError("AssociatedPullToRefreshActionKeys.pullAction is nil.")
        }
        action(refreshControl)
        print("Pull To Refresh")
    }

    private struct AssociatedPullToRefreshActionKeys {
        static let pullAction = UnsafeRawPointer(bitPattern: "pullAction".hashValue)
    }


    func scrollToTop(animated: Bool = true, with topMargin : CGFloat = 0.0) {
         let topOffset = CGPoint(x: 0, y: -contentInset.top + topMargin)
         setContentOffset(topOffset, animated: animated)
     }
    
    func scrollToBottomWithBottomMargin(){
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: true)
    }
    
    
}

// BELOW FUNCTION HELPS TO CONVERT THE UICOLOR TO CGCOLOR IF THE BORDER-COLOR IS ADDED FROM THE RUNTIME ATTRIBUTE IN STORYBOARD
extension CALayer {
    open override func setValue(_ value: Any?, forKey key: String) {
        guard key == "borderColor", let color = value as? UIColor else {
            super.setValue(value, forKey: key)
            return
        }

        self.borderColor = color.cgColor
    }
}


extension UITextView{
    func getLatestString(in range : NSRange, with string: String) -> String{
        (self.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
    }
}

extension UITextField{
    func getLatestString(in range : NSRange, with string: String) -> String{
        (self.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
    }
}

extension UILabel{

    func setTextWithSpecificLineHeight(with text: String, lineSpacing: CGFloat, lineBreakMode: NSLineBreakMode = .byTruncatingTail) {
        // Create a paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineBreakMode = lineBreakMode
        
        // Create an attributed string with the paragraph style
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: self.font as Any, // Preserve the UILabel's font
                .foregroundColor: self.textColor as Any // Preserve text color
            ]
        )

        // Set the attributed string to the UILabel
        self.attributedText = attributedString
    }
}

extension UITextView {
    
    func setTextWithSpecificLineHeight(with text: String, lineSpacing: CGFloat) {
        // Create a paragraph style
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        // Create an attributed string with the paragraph style
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: self.font as Any, // Preserve the UILabel's font
                .foregroundColor: self.textColor as Any // Preserve text color
            ]
        )

        // Set the attributed string to the UILabel
        self.attributedText = attributedString
    }
    
}

extension UIView{
    
    func addZeroConstraints(equalTo : UIView){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.topAnchor.constraint(equalTo: equalTo.topAnchor),
            self.leadingAnchor.constraint(equalTo: equalTo.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: equalTo.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: equalTo.bottomAnchor)
            
        ])
        
    }
    
}

extension UIViewController{
    
    func adjustKeyboardToView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
//        guard self.view.frame.origin.y == 0 else { return }
        
        if let activeView = view.findFirstResponder() {
    
            let activeViewFrame = activeView.convert(activeView.bounds, to: view)
            
            let bottomSpace = view.frame.height - (activeViewFrame.origin.y + activeViewFrame.height)
            
            if bottomSpace < keyboardSize.height {
                let moveDistance = keyboardSize.height - bottomSpace + 20
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin.y = -moveDistance
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }

}

extension UIViewController{
    func adjustKeyboardToScreen(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowInScreen), name: UIResponder.keyboardWillShowNotification, object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideInScreen), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShowInScreen(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHideInScreen(notification: NSNotification) {
        if view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
        }
    }
    
    func keyboardWillOpen() {
        let notification :NSNotification = NSNotification()
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
}

extension UIView {
    func findFirstResponder() -> UIView? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}

extension UIViewController{
    
    func showPopUpView(_ popUp : UIView , isShowInTabBar : Bool = false , completion : PassBoolClosure? = nil){

        var view = self.view!
        
        if isShowInTabBar, let tabBarVC = self.tabBarController{
            view = tabBarVC.view
        }
        popUp.alpha = 0
        
        view.endEditing(true)
        popUp.frame = view.bounds
    
        view.addSubview(popUp)
        view.bringSubviewToFront(popUp)
        
        UIView.animate(withDuration: 0.35, animations: { [ weak self ] in
            guard let _ = self else { return }
            
            popUp.alpha = 1
            
        }, completion: completion)  // UIView.animate
        
    }
    
}

extension UITableView{
    func reloadAndScrollToBottom(animated: Bool = true) {
        DispatchQueue.main.async {
            self.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                let lastSection = self.numberOfSections - 1
                guard lastSection >= 0 else { return }
                let lastRow = self.numberOfRows(inSection: lastSection) - 1
                guard lastRow >= 0 else { return }
                let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
                self.scrollToRow(at: lastIndexPath, at: .bottom, animated: animated)
            }
        }
    }  // func reloadAndScrollToBottom(animated: Bool = true)
}
