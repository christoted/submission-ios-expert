//
//  SearchRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 11/07/21.
//

import Foundation
import UIKit


class SearchRouter {
    func createSearchModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        
        
        let searchUseCase = Injection().provideHomeUseCase()
        let presenter = SearchPresenter(useCase: searchUseCase, searchRouter: SearchRouter())
        
        searchVC.presenter = presenter
        searchVC.presenter?.searchRouter = SearchRouter()
        searchVC.presenter?.searchViewController = searchVC
        
        return searchVC
    }
    
    func navigateToDetailModule()->DetailPresenter {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailRecipeViewController") as DetailRecipeViewController
        
        let detailUseCase = Injection().provideHomeUseCase()
        let presenter = DetailPresenter(useCase: detailUseCase)
        
        detailVC.presenter = presenter
        detailVC.presenter?.router = HomeRouter()
        detailVC.presenter?.detailView = detailVC
        
        return presenter
    }
}
