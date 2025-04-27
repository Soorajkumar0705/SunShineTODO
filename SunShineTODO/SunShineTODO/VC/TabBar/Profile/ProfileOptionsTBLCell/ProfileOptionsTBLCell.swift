//
//  ProfileOptionsTBLCell.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//

import UIKit

class ProfileOptionsTBLCell: UITableViewCell, NibReusable {
    
    typealias DataItemType = ProfileOptions
    
    @IBOutlet private weak var imgOption : UIImageView!
    @IBOutlet private weak var vwOptionSideContainerView : UIView!
    @IBOutlet private weak var lblOptionName : UILabel!
    @IBOutlet private weak var vwLineView: UIView!
    
    
    var isShowLineView : Bool = true {
        didSet{
            vwLineView.isHidden = !isShowLineView
        }
    }
    
    var dataItem : DataItemType! {
        didSet{
            updateUIWithData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
    }
    
    
    private func updateUIWithData(){
       
        imgOption.image = dataItem.image
        imgOption.tintColor = dataItem.tintColor
        lblOptionName.text = dataItem.title
        vwOptionSideContainerView.backgroundColor = dataItem.bgColor
        
        print(#function)
    }
    
}
