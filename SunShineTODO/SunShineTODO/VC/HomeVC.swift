//
//  HomeVC.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 19/04/25.
//

import UIKit


class HomeVC : UIViewController, StoryboardBased {
    
    @IBOutlet private weak var txtFind: UITextField!
    
    @IBOutlet private weak var vwNoNotes: UIView!
    @IBOutlet private weak var lblNoNotesMessage: UILabel!
    
    @IBOutlet private weak var tblTasks: TaskTableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI(){
        addClearButtOnToolBar()
        
        txtFind.delegate = self
        txtFind.placeholder = "Find your TO DO Task"
        txtFind.textColor = .black
        
        lblNoNotesMessage.text = "No TO DO's Right Now! \n Please Create New "
        
        configureTableView()
    }
    
    private func configureTableView(){
        
        tblTasks.didReloadTableView = { [weak self] in
            guard let self else { return }
            
            if tblTasks.dataItems.count > 0 {
                vwNoNotes.isHidden = true
                tblTasks.isHidden = false
                
            }else{
                vwNoNotes.isHidden = false
                tblTasks.isHidden = true
            }
        }
        
        tblTasks.didClickMoreOptions = { [weak self] in
            guard let self else { return }
            
            showBottomSheet()
            
        }
        
        tblTasks.configure()
        TaskManager.shared.taskData = TaskManager.shared.getTask()
        tblTasks.dataItems = TaskManager.shared.taskData
        tblTasks.reloadData()
    }
    
    
    
    @IBAction private func onClickBtnOpenSideMenu(_ sender: UIButton) {
        
        print(#function)
    }
    
    @IBAction private func onClickBtnSearch(_ sender: UIButton) {
        
        print(#function)
    }
    
    @IBAction private func onClickBtnAddTODO(_ sender: UIButton) {
        let vc = AddTaskVC.instantiate(from: .main)
        
        vc.didAddedTaskSuccessfully = { [weak self] in
            guard let self else { return }
            tblTasks.reloadData()
        }
        
        vc.presentAsChildVC(in: self, animated: true)
        
        print(#function)
    }
    
}

extension HomeVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let latestString = textField.getLatestString(in: range, with: string)
        
        if latestString.isEmpty {
            tblTasks.dataItems = TaskManager.shared.taskData
        }else{
            
            let filteredTasks = TaskManager.shared.taskData.filter({ $0.title.contains(latestString) })
            
            tblTasks.dataItems = filteredTasks
        }
        
        tblTasks.reloadData()
        
        return true
    }
    
}

extension HomeVC {
    
    private func addClearButtOnToolBar(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(onClearText(_:)))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        txtFind.inputAccessoryView = doneToolbar
    }
    
    @objc private func onClearText(_ sender : Any){
        txtFind.resignFirstResponder()
        txtFind.text = ""
        tblTasks.dataItems = TaskManager.shared.taskData
        tblTasks.reloadData()
    }
    
}

extension HomeVC {
    
    func showBottomSheet(){
        guard let selectedIndexPath = self.tblTasks.selectedIndexPath else { return }
        let selectedTaskData = TaskManager.shared.taskData[selectedIndexPath.row]
        
        let actionSheet = UIAlertController(title: "More Option", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(
            title: "Mark as \(selectedTaskData.isCompleted ? "Uncomplete" : "Complete")",
            style: .default, handler: { _ in
            print("Mark as complete selected")
            
                TaskManager.shared.taskData[selectedIndexPath.row].isCompleted =
                !TaskManager.shared.taskData[selectedIndexPath.row].isCompleted
                
        }))

        actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            
            if let selectedIndexPath = self.tblTasks.selectedIndexPath {
                let taskData = TaskManager.shared.taskData[selectedIndexPath.row]
                TaskManager.shared.deleteTask(task: taskData)
            }
            
            print("delete selected")
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        // For iPad: required to avoid crash
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }

        self.present(actionSheet, animated: true, completion: nil)

    }
}
