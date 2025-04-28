//
//  HomeVC.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 19/04/25.
//

import UIKit

class HomeVCFactory {
    
    func makeVC() -> HomeVC {
        HomeVC.instantiate(from: .tabBar)
    }
    
}

class HomeVC : UIViewController, StoryboardBased {
    
    @IBOutlet private weak var txtFind: UITextField!
    @IBOutlet private weak var lblNoNotesMessage: UILabel!
    
    @IBOutlet private weak var tblTasks: TaskTableView!
    
    
    private var taskManager : TaskAPIManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskManager = TaskAPIManager(apiService: APIServiceFactory().makeAPIService())
        taskManager.delegate = self
        
        updateUI()
        
    }
    
    private func updateUI(){
        addClearButtOnToolBar()
        
        txtFind.delegate = self
        txtFind.placeholder = "Find your To Do Task"
        txtFind.textColor = .black
        
        lblNoNotesMessage.text = "No To Do's Right Now! \n Please Create New "
        
        configureTableView()
        
        NotificationCenter.default.addObserver(forName: .didReceiveCreateToDoResponse, object: nil, queue: .main, using: { [weak self] notification in
            guard let self else { return }
            taskManager.getToDoList()
        })
    }
    
    private func configureTableView(){
        
        tblTasks.didReloadTableView = { [weak self] in
            guard let self else { return }
            
            if tblTasks.dataItems.count > 0 {
                lblNoNotesMessage.isHidden = true
                tblTasks.isHidden = false
                
            }else{
                lblNoNotesMessage.isHidden = false
                tblTasks.isHidden = true
            }
        }
        
        tblTasks.didClickMoreOptions = { [weak self] indexPath in
            guard let self else { return }
            
            showBottomSheet()
            
        }
        
        tblTasks.didClickFavoriteTodo = { [weak self] indexPath in
            guard let self else { return }
            
            guard let selectedIndexPath = self.tblTasks.selectedIndexPath else { return }
            let selectedTaskData = taskManager.toDoList[selectedIndexPath.row]
            
            taskManager.favoriteToDoTask(
                taskId: selectedTaskData.id,
                isFavorite: selectedTaskData.isFavorite.isTrue() ? false : true
            )
            
        }
        
        tblTasks.configure()
        taskManager.getToDoList()
    }
    
    
    
    @IBAction private func onClickBtnOpenSideMenu(_ sender: UIButton) {
        SideMenuVC.instantiate(from: .main)
            .presentAsChildVC(in: self, animated: true)
        print(#function)
    }
    
    @IBAction private func onClickBtnSearch(_ sender: UIButton) {
        txtFind.becomeFirstResponder()
        print(#function)
    }
    
}

extension HomeVC : TaskAPIManagerDelegate {
    
    func didRecieveTodoListDataResponse() {
        DispatchQueue.main.async {  [weak self] in
            guard let self else { return }
            tblTasks.selectedIndexPath = nil    
            tblTasks.dataItems = taskManager.toDoList
            tblTasks.reloadData()
        }
    }
    
    func didRecieveCreateToDoResponse() {
        taskManager.getToDoList()
        print("I am here in ", #function)
    }
    
    func didCreatedTODO() {
        taskManager.getToDoList()
        print("I am here in ", #function)
    }
    
    func didRecievUpdateTodoRespobse() {
        
    }
    
    func didRecieveDeleteToDoResponse() {
        
    }

    
}

extension HomeVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let latestString = textField.getLatestString(in: range, with: string)
        
        if latestString.isEmpty {
            tblTasks.dataItems = taskManager.toDoList
        }else{
            
            let filteredTasks = taskManager.toDoList.filter({ $0.title.lowercased().contains(latestString.lowercased()) })
            
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
        tblTasks.dataItems = taskManager.toDoList
        tblTasks.reloadData()
    }
    
}

extension HomeVC {
    
    func showBottomSheet(){
        guard let selectedIndexPath = self.tblTasks.selectedIndexPath else { return }
        let selectedTaskData = taskManager.toDoList[selectedIndexPath.row]
        
        let actionSheet = UIAlertController(title: "More Option", message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(
            title: "Mark as \((selectedTaskData.isCompleted.isTrue() == true ) ? "Uncomplete" : "Complete")",
            style: .default, handler: { [weak self] _ in
            print("Mark as complete selected")
            
                self?.taskManager.markCompleteToDoTask(
                    taskId: selectedTaskData.id,
                    isCompleted: (selectedTaskData.isCompleted.isTrue() == true ) ? false : true
                )

        }))

        actionSheet.addAction(UIAlertAction(title: "Delete", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            showDeleteAlert()
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
    
    
    private func showDeleteAlert() {
        let vc = PopUpVCFactory()
            .setTitle("Delete?")
            .setMessage("Are you sure, you want to delete this task?")
            .make()
        
        vc.onClickBtnNo = { [weak self] in
            guard let _ = self else { return }
        }
        
        vc.onClickBtnYes = { [weak self] in
            guard let self,
                  let selectedIndexPath = tblTasks.selectedIndexPath
            else { return }
            
            let taskData = taskManager.toDoList[selectedIndexPath.row]
            taskManager.deleteToDoTask(taskId: taskData.id)
        }
        
        vc.presentAsChildVCInTabBarVC(in: self, animated: true)
        
    }
    
}
