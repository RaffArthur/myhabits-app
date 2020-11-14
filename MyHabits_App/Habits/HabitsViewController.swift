//
//  HabitsViewController.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 08.11.2020.
//

import UIKit

class HabitsViewController: UIViewController {
    
    lazy var addHabit: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.image = .add
        bbi.style = .plain
        bbi.tintColor = UIColor(named: "AccentColor")
        return bbi
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        view.backgroundColor = .white
    
        title = "Привычки"
    }
}
