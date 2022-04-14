//
//  TabBarVC.swift
//  SecureMyHouse
//
//  Created by Connor Przybyla on 4/9/22.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        let viewControllers = buildViewControllers()
        self.viewControllers = viewControllers
    }
    
    private func buildViewControllers() -> [UIViewController] {
        let homeViewModel = HomeViewModel(urlSession: URLSession.shared)
        let homeVC = HomeVC(viewModel: homeViewModel)
        let homeTabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        homeVC.tabBarItem = homeTabBarItem
        
        let historyVC = HomeVC(viewModel: homeViewModel)
        let historyTabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        historyVC.tabBarItem = historyTabBarItem
        
        return [homeVC, historyVC]
    }
}
