//
//  AppTabBarController.swift
//  SimplyFit
//
//  Created by Patrick Montalto on 6/10/17.
//  Copyright © 2017 Patrick Montalto. All rights reserved.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create history view controller
        let historyViewController = HistoryViewController()
        let historyNav = UINavigationController(rootViewController: historyViewController)
        let historyTabBarItem = UITabBarItem(title: "History", image: nil, selectedImage: nil)
        historyNav.tabBarItem = historyTabBarItem
        
        // Create workout view controller
        let workoutViewController = WorkoutViewController()
        let workoutNav = UINavigationController(rootViewController: workoutViewController)
        let workoutTabBarItem = UITabBarItem(title: "Workout", image: nil, selectedImage: nil)
        workoutNav.tabBarItem = workoutTabBarItem
        
        // Create profile view controller
        let profileViewController = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileViewController)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: nil, selectedImage: nil)
        profileNav.tabBarItem = profileTabBarItem
        
        // Set View Controllers
        viewControllers = [historyNav, workoutNav, profileNav]
        
        // Set workoutNav as selected
        selectedIndex = 1
    }
    
    
}
