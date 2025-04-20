//
//  ToastMessageView.swift
//  Kado
//
//  Created by Suraj kahar on 09/04/25.
//

import UIKit

class ToastMessageView: UIView , NibLoadable{
    
    @IBOutlet private weak var lblMessage: AlbertSansMediumLabel!
    @IBOutlet private weak var lblMessageContainerBottomConstraint: NSLayoutConstraint!
    
    var bottomMargin : CGFloat = 20.0{
        didSet{
            lblMessageContainerBottomConstraint.constant = bottomMargin
        }
    }
    
    var message : String = "" {
        didSet{
            lblMessage.text = message
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        updateUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        updateUI()
    }
    
    deinit{
        print("Removed \(className) automatically from memory.")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    private func updateUI(){
        self.accessibilityIdentifier = className
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }   // private func updateUI()
    
}
