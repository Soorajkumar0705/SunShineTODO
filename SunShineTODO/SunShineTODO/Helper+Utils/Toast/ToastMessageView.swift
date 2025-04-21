//
//  ToastMessageView.swift
//  Kado
//
//  Created by Suraj kahar on 09/04/25.
//

import UIKit

class ToastMessageView: UIView , NibLoadable{
    
    var bottomMargin : CGFloat = 20.0{
        didSet{
        }
    }
    
    var message : String = "" {
        didSet{
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    init (message : String, bottomMargin : CGFloat = 20.0) {
        super.init(frame: .zero)
        
        self.message = message
        self.bottomMargin = 40.0//bottomMargin
        
        updateUI()
    }
    
    deinit{
        print("Removed \(className) automatically from memory.")
    }

    
    private func updateUI(){
        self.accessibilityIdentifier = className
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        
        createToastUI()
        
    }   // private func updateUI()
    
    private func createToastUI(){
        
        let containerView = UIView()
        
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemIndigo.cgColor
        containerView.clipsToBounds = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomMargin),
        ])
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .black
        toastLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(toastLabel)
        
        
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            toastLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            toastLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            toastLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
        ])
        
    }
    
}
