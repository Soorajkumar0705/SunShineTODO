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
        
        if let taskDetails = dataItem.taskDetails {
            lblDescription.text = taskDetails
            lblDescription.isHidden = false
        }else{
            lblDescription.isHidden = true
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy, h:mm a"
        let formattedDate = formatter.string(from: dataItem.dueDate)
        lblDueDate.text = formattedDate
        
        btnFavUnfavTasks.setImage(
            dataItem.isFavorite
            ? UIImage(systemName: "star.fill")
            : UIImage(systemName: "star"),
            for: .normal
        )
        
        if dataItem.isCompleted {
            lblPriority.text = "Completed"
            lblPriority.superview?.backgroundColor = .systemGreen
        }else{
            
            lblPriority.text = dataItem.priority.rawValue
            lblPriority.superview?.backgroundColor =
            switch dataItem.priority {
            case .high: UIColor.systemRed.withAlphaComponent(0.8)
            case .medium: UIColor.systemOrange.withAlphaComponent(0.8)
            case .low: UIColor.systemYellow.withAlphaComponent(0.8)
            }
            
        }
        print(#function)
    }
    
    @IBAction private func onClickBtnMoreOptions(_ sender: UIButton) {
        onClickMoreOptions?()
        print(#function)
    }
    
    @IBAction private func onClickBtnFavUnFavTask(_ sender: UIButton) {
        
        if dataItem.isFavorite {
            TaskManager.shared.unfavTask(taskData: dataItem)
        }else{
            TaskManager.shared.favTask(taskData: dataItem)
        }
        
        dataItem.isFavorite.toggle()
        onClickFavUnFavTask?()
        print(#function)
    }
    
    
    
}
