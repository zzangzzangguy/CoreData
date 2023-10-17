//
//  SceneDelegate.swift
//  ToDO
//
//  Created by 김기현 on 2023/08/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let mainVC = MainVC()
        let mainNavigationController = UINavigationController(rootViewController: mainVC)
        
        let todoVC = ViewController()
        
        var user = User(username: "kill bong", followersCount: 100, followingCount: 200, postCount: 50)
        user.FeedDataAr = [FeedData(FeedImage: UIImage(named: "문상훈1")!),
                           FeedData(FeedImage: UIImage(named: "문상훈2")!),
                           FeedData(FeedImage: UIImage(named: "문상훈3")!)
        ]
        
        let profileViewController = ProfileViewController(user: user)
        profileViewController.tabBarItem = UITabBarItem(
            title: "프로필",
            image: UIImage(systemName: "person.fill"),
            selectedImage: nil
        )
        
        mainVC.tabBarItem = UITabBarItem(
            title: "메인",
            image: UIImage(systemName: "star.fill"),
            selectedImage: nil
        )
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [profileViewController, mainNavigationController]
        let tabBar = tabBarController.tabBar
        tabBar.backgroundColor = UIColor.clear
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.orange
        tabBar.unselectedItemTintColor = UIColor.lightGray
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

