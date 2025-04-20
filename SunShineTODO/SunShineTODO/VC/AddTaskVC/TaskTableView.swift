//
//  TaskTableView.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import UIKit

class TaskTableView: UITableView , UITableViewDataSource, UITableViewDelegate{
    
    typealias DataItemType = TaskDataModel
    typealias CELLType = UITableViewCell
    typealias CellConfigureType = (IndexPath, DataItemType, CELLType) -> Void
    
    
    var configureCell: CellConfigureType?
    
    var dataItems : [DataItemType]  = []{
        didSet{
            
        }
    }
    
    var didReloadTableView : VoidClosure?
    
    func configure(with dataItems : [DataItemType] = []) {
        self.register(cellType: CELLType.self)
        
        if !dataItems.isEmpty{
            self.dataItems = dataItems
        }
        
        dataSource = self
        delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        didReloadTableView?()
        
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}
