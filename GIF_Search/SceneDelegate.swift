//
//  SceneDelegate.swift
//  GIF_Search
//
//  Created by 동준 on 5/19/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = SearchViewController()
        self.window?.makeKeyAndVisible()
    }
}
