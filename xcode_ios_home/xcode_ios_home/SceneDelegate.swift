//
//  SceneDelegate.swift
//  xcode_ios_home
//
//  Created by Rezo on 09.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene) // создаем объект окна
        let viewController = ViewController()
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
