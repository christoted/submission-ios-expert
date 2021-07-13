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
}
