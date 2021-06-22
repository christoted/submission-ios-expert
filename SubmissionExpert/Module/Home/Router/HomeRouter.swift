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
        let viewController = HomeViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
        
        let homeUseCase = Injection().provideHomeUseCase()
        let presenter = HomePresenter(useCase: homeUseCase)
        
        viewController.presenter = presenter
        viewController.presenter?.homeRouter = HomeRouter()
        viewController.presenter?.homeView = viewController
        
        return viewController
    }
    
    
}
