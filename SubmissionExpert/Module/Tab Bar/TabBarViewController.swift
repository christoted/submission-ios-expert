//
//  TabBarViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/05/21.
//

import UIKit

typealias MealTab = (
    home: UIViewController,
    favorite: UIViewController,
    profile: UIViewController
)


class TabBarViewController: UITabBarController {
    
    init(tabs: MealTab) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.home, tabs.favorite, tabs.profile]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}


