//
//  HomeRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 17/06/21.
//

import Foundation
import UIKit

//Implement with Protocol Delegate
protocol HomeRouterDelegate  {
    func createHomeModule()->UIViewController
}

class HomeRouter: HomeRouterDelegate {
    
    func createHomeModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        
        let homeUseCase = Injection().provideHomeUseCase()
        let presenter = HomePresenter(useCase: homeUseCase)
        
        homeVC.presenter = presenter
        homeVC.presenter?.homeRouter = HomeRouter()
        homeVC.presenter?.homeView = homeVC
        
        return homeVC
    }
    
    
}
