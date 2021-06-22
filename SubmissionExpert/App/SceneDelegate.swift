//
//  SceneDelegate.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let homeVC = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {
            print("ViewController not found")
            return
        }
        
        guard let homeNC = storyboard.instantiateViewController(identifier: "HomeNavigationController") as? HomeNavigationViewController else {
            print("ViewController not found")
            return
        }
        
        guard let detailVC = storyboard.instantiateViewController(identifier: "DetailRecipeViewController") as? DetailRecipeViewController else {
            print("ViewController not found")
            return
        }
     
        
        guard let favouriteVC = storyboard.instantiateViewController(identifier: "FavouriteViewController") as? FavouriteViewController else {
            print("ViewController not found")
            return
        }
        
        guard let favouriteNC = storyboard.instantiateViewController(identifier: "FavouriteNavigationController") as? FavouriteNavigationController
        else {
            
            return
        }
        
        
        guard let personalVC = storyboard.instantiateViewController(identifier: "ProfileViewController") as? ProfileViewController else {
            print("ViewController not found")
            return
        }
        
        guard let personalNC =
                storyboard.instantiateViewController(identifier: "ProfileNavigationController") as? ProfileNavigationViewController else {
            print("ViewController not found")
            return
        }
        
        let tabBarController  = storyboard.instantiateViewController(withIdentifier: "tabbar") as! TabBarViewController

        
        favouriteNC.viewControllers = [favouriteVC]
        homeNC.viewControllers = [homeVC]
        tabBarController.viewControllers = [homeNC, favouriteNC, personalNC]
        
        
        
        
        //Edit
        
        
        
        
        let submodules = (home: HomeViewController() ,favorite: FavouriteViewController() , profile: ProfileViewController())
        let tabBarController2 = TabBarModularBuilder.build(usingSubmodules: submodules)
        
        
        window?.rootViewController = tabBarController2
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    }
    
    
}

