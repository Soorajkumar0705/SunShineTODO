//
//  TabBarVC.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 27/04/25.
//

import UIKit

class TabBarVCFactory {
    
    func makeVC() -> TabBarVC {
        TabBarVC.instantiate(from: .tabBar)
    }
    
}

class TabBarVC: UITabBarController, StoryboardBased {

    private var lastSelectedIndex : Int = 0
    var customHomeTabBar: BottomTabBarView!

    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.selectedIndex = 0
        self.view.backgroundColor = .clear
        self.tabBar.backgroundColor = .clear

        self.tabBar.isHidden = true
        addCustomHomeTabBar()
    }

    private func addCustomHomeTabBar(){

        let viewHeight =  self.view.bounds.height
        let tabHeight = ((self.view.frame.width * 65 ) / 360)

        let frame = CGRect(x: self.tabBar.frame.origin.x, y: viewHeight - tabHeight - (isSmallerDevice ? 0 : 20), width: self.tabBar.frame.width,  height: tabHeight + (isSmallerDevice ? 0 : 20))

        self.customHomeTabBar = BottomTabBarView(frame: frame)
        self.view.addSubview(customHomeTabBar)
        self.view.bringSubviewToFront(customHomeTabBar)
        self.customHomeTabBar.selectedTab = self.selectedIndex

        self.customHomeTabBar.onClickTabButton = { [weak self] senderTag in

            guard let self else { return }

            if senderTag == self.selectedIndex { return }

            var switchingIndexTag : Int = 0

            switch senderTag {

            case 0:
                print("Home")
                switchingIndexTag = 0

            case 1:
                print("Profile")
                switchingIndexTag = 1

                
            default:
                print("Unknown tag passed in closure function ",#function)

            }
            self.lastSelectedIndex = self.selectedIndex
            self.selectedIndex = switchingIndexTag

        }
        
        customHomeTabBar.onClickBtnAddToDo = {  [weak self] in
            guard let self else { return }
            AddTaskVC.instantiate(from: .tabBar)
                .presentAsChildVC(in: self, animated: true)
            
        }
        
    }

    func hideTabBar(){
        self.customHomeTabBar.isHidden = true
    }

    func showTabBar(){
        self.customHomeTabBar.isHidden = false
    }
    
    func lastVC(){
        selectedIndex = lastSelectedIndex
        customHomeTabBar.selectedTab = selectedIndex
    }

    func getTabBarHeight() -> CGFloat{
        return self.customHomeTabBar.frame.height
    }
    
}

extension TabBarVC : UITabBarControllerDelegate {



}
