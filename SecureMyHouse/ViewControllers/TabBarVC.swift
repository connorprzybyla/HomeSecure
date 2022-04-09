//
//  TabBarVC.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/9/22.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        let viewControllers = buildViewControllers()
        self.viewControllers = viewControllers
    }
    
    private func buildViewControllers() -> [UIViewController] {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        let homeTabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        homeVC.tabBarItem = homeTabBarItem
        
        let historyVC = HomeVC()
        let historyTabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        historyVC.tabBarItem = historyTabBarItem
        
        return [homeVC, historyVC]
    }
}
