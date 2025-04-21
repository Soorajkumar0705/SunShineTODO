//
//  TaskTBLCell.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import UIKit

class TaskTBLCell: UITableViewCell, NibReusable {

    typealias DataItemType = TaskDataModel
    
    @IBOutlet private weak var lblName : UILabel!
    @IBOutlet private weak var lblDescription : UILabel!
    @IBOutlet private weak var lblDueDate : UILabel!
    @IBOutlet private weak var lblPriority : UILabel!
    @IBOutlet private weak var lblCreatedAt : UILabel!
    
    
    
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
        lblName.text = dataItem.title
        
        if let taskDetails = dataItem.taskDetails {
            lblName.text = taskDetails
            lblName.isHidden = false
        }else{
            lblName.isHidden = true
        }
        
        
        print(#function)
    }
    
}
