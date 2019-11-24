//
//  AppDelegate.swift
//  Example
//
//  Created by ruixingchen on 11/7/19.
//  Copyright © 2019 ruixingchen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        RXCNavigationBarTransition.start()

        window = UIWindow()
        let debugVC = UINavigationController(rootViewController: DebugMenuViewController())
        debugVC.title = "Debug"
        let exampleVC = UINavigationController(rootViewController: ExampleMenuViewController())
        exampleVC.title = "Example"
        let tab = UITabBarController()
        tab.setViewControllers([exampleVC, debugVC], animated: false)
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
        //window?.layer.speed = 0.5

        return true
    }

}

