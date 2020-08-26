//
//  AppDelegate.swift
//  SudoKuManagerGame
//
//  Created by top on 2020/8/24.
//  Copyright © 2020 top. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        let nav = UINavigationController()
        nav.pushViewController(LevelController(), animated: true)
        window?.rootViewController = nav
        
        return true
    }
}

