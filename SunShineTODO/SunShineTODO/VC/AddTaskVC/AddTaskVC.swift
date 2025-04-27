//
//  AddTaskVC.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 19/04/25.
//

import UIKit

class AddTaskVC : UIViewController, StoryboardBased {

    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var bottomContainerView: UIView!
    
    @IBOutlet private weak var txtTaskName: UITextField!
    @IBOutlet private weak var txtDescription: UITextView!
    @IBOutlet private weak var lblSelectedDueDate: UILabel!
    
    
    
    let taskDetailsPlaceholder = "Description..."
    var builder : CreateToDoRequestBuilder?
    var taskManager : TaskAPIManager?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentVCWithAnimation()
        updateUI()
        
        builder = CreateToDoRequestBuilder()
        taskManager = TaskAPIManager(apiService: APIServiceFactory().makeAPIService())
        taskManager?.delegate = self
    }
    
    private func updateUI(){
        txtTaskName.addKeyboardDismissAbilityOnToolBarDoneButton()
        txtTaskName.placeholder = "Enter task title..."
        txtTaskName.textColor = .black

        
        txtDescription.addKeyboardDismissAbilityOnToolBarDoneButton()
        addKeyBoardOpenCloseHandleUIStateObserver()
        
        bgView.addTapGesture(action: { [weak self] _ in
            guard let self else { return }
            removeChildVCWithAnimation()
        })
        
    }
    
    @IBAction private func onClickBtnSelectDate(_ sender: UIButton) {
        let vc = DateSelectionVC.instantiate(from: .tabBar)
        
        vc.didSelectedDate = { [weak self] selectedDate in
            guard let self else { return }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "d MMMM yyyy, h:mm a"
            let formattedDate = formatter.string(from: selectedDate)
            
            lblSelectedDueDate.text = formattedDate
            
            _=builder?.setDueDate(selectedDate)
        }
        
        vc.presentAsChildVC(in: self, animated: true)
        
        print(#function)
    }
    
    @IBAction private func onChangePriorityValue(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
            
        case 0: _=builder?.setTaskPriority(.low)
        case 1: _=builder?.setTaskPriority(.medium)
        case 2: _=builder?.setTaskPriority(.high)
            
        default:
            break;
            
        }
        
        print(#function)
    }
    
    
    @IBAction private func onClickBtnCancel(_ sender: UIButton) {
        removeChildVCWithAnimation()
        print(#function)
    }
    
    @IBAction private func onClickBtnSaveTask(_ sender: UIButton) {
        createTask()
        print(#function)
    }
    
    
}

extension AddTaskVC {
 
    func createTask(){
        guard builder != nil else { return }
        
        _=builder?.setTitle(txtTaskName.text)
        
        if taskDetailsPlaceholder != txtDescription.text{
            _=builder?.setTaskDetails(txtDescription.text)
        }
        taskManager?.createToDoTask(task: builder!)

    }
    
}

extension AddTaskVC : TaskAPIManagerDelegate {
    
    func didRecieveTodoListDataResponse() {
        
    }
    
    func didRecieveCreateToDoResponse() {
        DispatchQueue.main.async {  [weak self] in
            guard let self else { return }
            
            NotificationCenter.default.post(name: .didReceiveCreateToDoResponse, object: nil)
            removeChildVCWithAnimation()
        }
    }
    
    func didRecievUpdateTodoRespobse() {
        
    }
    
    func didRecieveDeleteToDoResponse() {
        
    }

    
}


extension AddTaskVC {
    
    private func presentVCWithAnimation(){
        
        bottomContainerView.frame.origin.y += (bottomContainerView.frame.height + 100)
        bottomContainerView.isHidden = false
        
        CommonFunctions.generateHapticFeedback()
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = .black.withAlphaComponent(0.25)
            bottomContainerView.frame.origin.y -= (bottomContainerView.frame.height + 100)
        })
        
        
    }
    
    private func removeChildVCWithAnimation(){
        UIView.animate(withDuration: 0.3) {  [weak self] in
            guard let self else { return }
            view.backgroundColor = .clear
            bottomContainerView.frame.origin.y += (bottomContainerView.frame.height + 100)
            
        } completion: { [weak self] _ in
            guard let self else { return }
            removeChildVC(self)
        }
    }
    
    
    private func addKeyBoardOpenCloseHandleUIStateObserver(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: { [weak self] notification in
                guard let self else { return }
                
//                guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
//                else { return }
                
            bottomContainerView.frame.origin.y = 50
                
            })
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using: { [weak self] notification in
                guard let self else { return }
                
                guard let _ /*keyboardFrame*/ = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                else { return }
            
            bottomContainerView.frame.origin.y = (view.frame.height)-bottomContainerView.frame.height
            
            })
    }
    
}
