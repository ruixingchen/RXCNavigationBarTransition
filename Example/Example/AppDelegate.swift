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
        window?.rootViewController = UINavigationController(rootViewController: MainMenuViewController(style: .grouped))
        window?.makeKeyAndVisible()

        return true
    }

}

