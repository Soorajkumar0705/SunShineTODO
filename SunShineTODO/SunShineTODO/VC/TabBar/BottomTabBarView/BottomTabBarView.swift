//
//  BottomTabBarView.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//

import UIKit

class BottomTabBarView: UIView, NibLoadable {
    
    @IBOutlet private var imgTabGroup: [UIImageView]!
    @IBOutlet private var lblTabGroup: [UILabel]!

    var selectedTab: Int = 0 {

       willSet{
//           removeSelectionFromTab(tag: selectedTab)
       }

       didSet{
           selectTab(tag: selectedTab)
       }
   }

   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       initialCommit()
   }

   override init(frame: CGRect) {
       super.init(frame: frame)
       initialCommit()
   }

   deinit {
       print("Removed \(className) automatically from memory.")
   }

   private func initialCommit(){
       loadNibContent()
       updateUI()
   }
    
    var onClickTabButton: ( (Int) -> Void )? = nil
    var onClickBtnAddToDo: ( () -> Void )? = nil

   override func awakeFromNib() {
       super.awakeFromNib()
       updateUI()
   }

   private func updateUI(){

   }

   func selectTab(tag: Int) {
       for img in imgTabGroup{
           img.tintColor = (img.tag == tag) ? ._7_F_3_DFF : ._91919_F
       }
   }
    
    
    @IBAction private func onClickBtnAdd(_ sender: UIButton) {
        onClickBtnAddToDo?()
        print(#function)
    }
    
    @IBAction private func onClickTabButtons(_ sender: UIButton) {
       self.selectedTab = sender.tag
       onClickTabButton?(sender.tag)
       print(#function)
   }


}
