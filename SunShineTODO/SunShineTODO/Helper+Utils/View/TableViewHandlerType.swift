//
//  TableViewHandlerType.swift
//  Kado
//
//  Created by Harsh on 05/03/25.
//

import UIKit

protocol TableViewHandlerType: AnyObject{
    associatedtype itemsDataType
    
    var _tableView: UITableView { get }
    var items : [itemsDataType] { get set }
}


protocol TableViewDataSourceHandlerType : TableViewHandlerType, UITableViewDataSource {
    associatedtype itemsType = itemsDataType
    
    func reloadData(data: [itemsDataType])
}

extension TableViewDataSourceHandlerType {
    
    func reloadData(data: [itemsDataType]){
        items = data
        _tableView.reloadData()
    }
    
}

protocol TableViewDelegateHandlerType : TableViewHandlerType, UICollectionViewDelegate {

}
