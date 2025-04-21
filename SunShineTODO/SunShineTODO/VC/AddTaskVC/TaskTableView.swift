//
//  TaskTableView.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import UIKit

class TaskTableView: UITableView , UITableViewDataSource, UITableViewDelegate{
    
    typealias DataItemType = TaskDataModel
    typealias CELLType = TaskTBLCell
    typealias CellConfigureType = (IndexPath, DataItemType, CELLType) -> Void
    
    
    var configureCell: CellConfigureType?
    
    var dataItems : [DataItemType]  = []{
        didSet{
            
        }
    }
    
    var selectedIndexPath : IndexPath?
    var didClickMoreOptions: (() -> Void)?
    
    var didReloadTableView : VoidClosure?
    
    func configure(with dataItems : [DataItemType] = []) {
        self.register(cellType: CELLType.self)
        
        if !dataItems.isEmpty{
            self.dataItems = dataItems
        }
        
        dataSource = self
        delegate = self
        
        self.contentInset.top = 20
        self.contentInset.bottom = 50
        self.showsVerticalScrollIndicator = false
        
        NotificationCenter.default.addObserver(forName: .reloadData, object: nil, queue: .main, using: { [weak self] _ in
            guard let self else { return }
            self.dataItems = TaskManager.shared.taskData
            self.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        didReloadTableView?()
        
        return dataItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CELLType = tableView.dequeueReusableCell(for: indexPath)
        
        cell.dataItem = dataItems[indexPath.row]
        
        cell.onClickMoreOptions = {  [weak self] in
            guard let self else { return }
            selectedIndexPath = indexPath
            didClickMoreOptions?()
        }
        
        
        cell.onClickFavUnFavTask = {  [weak self] in
            guard let _ = self else { return }
            
        }
        
        return cell
    }
    
}
