//
//  AppDelegate.swift
//  iOSUsefulCode
//
//  Created by ruozui on 2020/3/24.
//  Copyright © 2020 rztime. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .white
        self.window?.rootViewController = UINavigationController.init(rootViewController: ViewController.init())
        return true
    }
}

