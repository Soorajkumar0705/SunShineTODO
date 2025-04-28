//
//  TaskTBLCell.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import UIKit

class TaskTBLCell: UITableViewCell, NibReusable {

    typealias DataItemType = ToDoTask
    
    @IBOutlet private weak var lblName : UILabel!
    @IBOutlet private weak var lblDescription : UILabel!
    @IBOutlet private weak var lblDueDate : UILabel!
    @IBOutlet private weak var lblPriority : UILabel!
//    @IBOutlet private weak var lblCreatedAt : UILabel!
    
    @IBOutlet private weak var btnMoreOptions: UIButton!
    @IBOutlet private weak var btnFavUnfavTasks: UIButton!
    
    
    var dataItem : DataItemType! {
        didSet{
            updateUIWithData()
        }
    }
    
    
    var onClickMoreOptions: (() -> Void)?
    var onClickFavUnFavTask: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
    }
    
    
    private func updateUIWithData(){
        lblName.text = dataItem.title
        
        if dataItem.description != ""{
            lblDescription.text = dataItem.description
            lblDescription.isHidden = false
        }else{
            lblDescription.isHidden = true
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy, h:mm a"
        
        if let date = formatter.date(from: dataItem.dueDate) {
            formatter.dateFormat = "MMM d, yyyy, h:mm a"
            let dateString = formatter.string(from: date)
            
            lblDueDate.text = dateString
        }
        
        btnFavUnfavTasks.setImage(
            dataItem.isFavorite.isTrue()
            ? UIImage(systemName: "star.fill")
            : UIImage(systemName: "star"),
            for: .normal
        )
        
        if dataItem?.isCompleted.isTrue() == true{
            lblPriority.text = "Completed"
            lblPriority.superview?.backgroundColor = ._7_F_3_DFF
        }else{
            
            lblPriority.text = dataItem.priority.title
            lblPriority.superview?.backgroundColor =
            switch dataItem.priority {
            case .high: UIColor.systemRed.withAlphaComponent(0.8)
            case .medium: UIColor.systemOrange.withAlphaComponent(0.8)
            case .low: UIColor.systemGreen
            }
            
        }
        print(#function)
    }
    
    @IBAction private func onClickBtnMoreOptions(_ sender: UIButton) {
        onClickMoreOptions?()
        print(#function)
    }
    
    @IBAction private func onClickBtnFavUnFavTask(_ sender: UIButton) {
        onClickFavUnFavTask?()
        print(#function)
    }
    
    
    
}
