//
//  OnboardingPagerDataModel.swift
//  SunRiseExpenseTracker
//
//  Created by Suraj kahar on 29/03/25.
//

import UIKit

struct OnboardingPagerDataModel : Identifiable, Hashable{
    
    var id : Int
    var img : UIImage
    var title: String
    var subTitle: String
    
    init(id : Int, img: UIImage, title: String, subTitle: String) {
        self.id = id
        self.img = img
        self.title = title
        self.subTitle = subTitle
    }
    
}   // OnboardingDataModel
