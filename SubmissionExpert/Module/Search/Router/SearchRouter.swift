//
//  SearchRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 11/07/21.
//

import Foundation
import UIKit

enum ViewControllerEmpty: Error {
    case notFound
    case notFoundAgain
}

class SearchRouter {
    func createSearchModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
      
        
    
        
        
        //        let homeUseCase = Injection().provideHomeUseCase()
        //        let presenter = HomePresenter(useCase: homeUseCase, homeRouter: HomeRouter())
        
        //        homeVC.presenter = presenter
        //        homeVC.presenter?.homeRouter = HomeRouter()
        //        homeVC.presenter?.homeView = homeVC
        
        return searchVC
    }
}
