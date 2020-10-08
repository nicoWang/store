//
//  SceneDelegate.swift
//  Store
//
//  Created by Nicolas Wang on 07/10/2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let module = ListModule()
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = module.listView()
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

