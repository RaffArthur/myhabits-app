//
//  AppDelegate.swift
//  MyHabits_App
//
//  Created by Arthur Raff on 08.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = TabBarViewController()
        window!.makeKeyAndVisible()
        
        return true
    }
}

