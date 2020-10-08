//
//  AppDelegate.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let module = ListModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = module.listView()
        window?.makeKeyAndVisible()
        return true
    }
}

