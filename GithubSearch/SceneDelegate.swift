//
//  SceneDelegate.swift
//  GithubSearch
//
//  Created by Jeongho Moon on 2022/11/03.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(
            rootViewController: SearchViewController()
        )
        window.makeKeyAndVisible()
        self.window = window
    }
}
