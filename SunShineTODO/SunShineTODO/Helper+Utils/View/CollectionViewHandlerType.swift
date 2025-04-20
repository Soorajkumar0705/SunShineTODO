//
//  CollectionViewHandlerType.swift
//  Kado
//
//  Created by Suraj kahar on 03/03/25.
//


import UIKit

//MARK: CollectionView Handler

protocol CollectionViewHandlerType: AnyObject {
    
    associatedtype itemsDataType
    
    var _collectionView: UICollectionView { get }
    var items : [itemsDataType] { get set }
}



//MARK: CollectionView DataSource
protocol CollectionViewDataSourceHandlerType : CollectionViewHandlerType, UICollectionViewDataSource {
    associatedtype itemsType = itemsDataType
    
    func reloadData(data: [itemsDataType])
}

extension CollectionViewDataSourceHandlerType {
    
    func reloadData(data: [itemsDataType]){
        items = data
        _collectionView.reloadData()
    }
    
}


//MARK: CollectionView Delegate
protocol CollectionViewDelegateHandlerType : CollectionViewHandlerType, UICollectionViewDelegate {

}
