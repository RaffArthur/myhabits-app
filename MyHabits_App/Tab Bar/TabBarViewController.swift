//
//  TabBarViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 08.11.2020.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    let habitsBarItem: UITabBarItem = {
        let tbi = UITabBarItem()
        tbi.image = UIImage(systemName: "rectangle.grid.1x2")
        tbi.selectedImage = UIImage(systemName: "rectangle.grid.1x2.fill")
        tbi.title = "Привычки"

        return tbi
    }()
    let infoBarItem: UITabBarItem = {
        let tbi = UITabBarItem()
        tbi.image = UIImage(systemName: "info.circle")
        tbi.selectedImage = UIImage(systemName: "info.circle.fill")
        tbi.title = "Информация"

        return tbi
    }()
    
    // MARK: - View funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    
        let habitsViewController = HabitsViewController()
        let infoViewController = InfoViewController()
        let tabBarList = [habitsViewController, infoViewController]

        habitsViewController.tabBarItem = habitsBarItem
        infoViewController.tabBarItem = infoBarItem

        viewControllers = tabBarList
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    
}
