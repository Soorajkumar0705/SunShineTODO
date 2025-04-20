//
//  LoaderView.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 19/04/25.
//

import UIKit

class LoaderView: UIView, NibLoadable {

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
    }

}
