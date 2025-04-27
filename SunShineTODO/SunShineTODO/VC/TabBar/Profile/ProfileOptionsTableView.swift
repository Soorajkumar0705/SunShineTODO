//
//  ProfileOptionsTableView.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//

import UIKit

class ProfileOptionsTableView : UITableView, UITableViewDataSource, UITableViewDelegate {
    
    typealias DataItemType = ProfileOptions
    typealias CELLType = ProfileOptionsTBLCell
    typealias CellConfigureType = (IndexPath, DataItemType, CELLType) -> Void
    
    
    var configureCell: CellConfigureType?
    var didSelectedItem : CellConfigureType?
    
    var dataItems : [DataItemType]  = []{
        didSet{
            
        }
    }
    
    private var heightConstraint: NSLayoutConstraint!
    
    func configure(with dataItems : [DataItemType] = []) {
        self.register(cellType: CELLType.self)
        updateInitialUIConfiguration()
        
        if !dataItems.isEmpty{
            self.dataItems = dataItems
        }
        
        dataSource = self
        delegate = self
        
        showsVerticalScrollIndicator = false
        
    }
    
    private func updateInitialUIConfiguration() {
        self.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        heightConstraint = heightAnchor.constraint(equalToConstant: 10)
        heightConstraint.priority = UILayoutPriority(1000)
        heightConstraint.isActive = true
        self.showsVerticalScrollIndicator = false
      }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataItems.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : CELLType = tableView.dequeueReusableCell(for: indexPath)
        
        cell.dataItem = dataItems[indexPath.row]
        cell.isShowLineView = (indexPath.row != dataItems.count - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didSelectedItem?(
            indexPath,
            dataItems[indexPath.row],
            tableView.cellForRow(at: indexPath) as! CELLType
        )
        
        print(#function)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard (keyPath == "contentSize"),
           let newValue = change?[.newKey] as? CGSize,
           (object as? UITableView) == self else {
          return
        }
        heightConstraint.constant = newValue.height
        self.superview?.layoutSubviews()
        self.layoutSubviews()
        self.layoutIfNeeded()
      }
    
}
