//
//  TabBarModularBuilder.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/06/21.
//

import Foundation
import UIKit

class TabBarModularBuilder {
    
    static func build(usingSubmodules submodules: TabBarRouter.Submodules)->UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubmodule: submodules)
        let tabBarController = TabBarViewController(tabs: tabs)
        
        return tabBarController
    }
    
}
