//
//  SceneDelegate.swift
//  Onban
//
//  Created by YEONGJIN JANG on 2022/09/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let mainVC = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }

}

