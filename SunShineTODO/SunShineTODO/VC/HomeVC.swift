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
        txtFind.addKeyboardDismissAbilityOnToolBarDoneButton()
        txtFind.placeholder = "Find your TO DO Task Here."
        txtFind.textColor = .black
        
        lblNoNotesMessage.text = "No TO DO's Right Now! \n Please Create New "
        
        
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
        
    }
    
    
    
    @IBAction private func onClickBtnOpenSideMenu(_ sender: UIButton) {
        
        print(#function)
    }
    
    @IBAction private func onClickBtnSearch(_ sender: UIButton) {
        
        print(#function)
    }
    
    @IBAction private func onClickBtnAddTODO(_ sender: UIButton) {
        AddTaskVC.instantiate(from: .main)
            .presentAsChildVC(in: self, animated: true)
        
        print(#function)
    }
    
}
