//
//  TabBarRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/06/21.
//

import Foundation
import UIKit

class TabBarRouter {
    var viewController: UIViewController
    var submodules: Submodules
    
    typealias Submodules = (
        home: UIViewController,
        favorite: UIViewController,
        profile: UIViewController
    )
    
    init(viewController: UIViewController, submodules: Submodules) {
        self.viewController = viewController
        self.submodules = submodules
    }
    
  
}

extension TabBarRouter {
    static func tabs(usingSubmodule submodules: Submodules) -> MealTab {
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: ""), tag: 10)
        let favoriteTabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: ""), tag: 11)
        let profileTabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: ""), tag: 12)
        
        submodules.home.tabBarItem = homeTabBarItem
        submodules.favorite.tabBarItem = favoriteTabBarItem
        submodules.profile.tabBarItem = profileTabBarItem
        
        
        return (
            home: submodules.home,
            favorite: submodules.favorite,
            profile: submodules.profile
        )
        
    }
    
    
    
}
