//
//  AddFoodRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 25/07/21.
//

import Foundation
import UIKit

class AddFoodRouter {
    
    func navigateToSearchFoodModule()->SearchFoodPresenter {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchFoodVC = storyboard.instantiateViewController(identifier: "searchfoodvc") as SearchFoodViewController
        
        let searchFoodNC = storyboard.instantiateViewController(identifier: "SearchFoodNavigationController") as SearchFoodNavigationController
        
        let useCase = Injection().provideHomeUseCase()
        let presenter = SearchFoodPresenter(useCase: useCase)
        
        searchFoodVC.searchFoodPresenter = presenter
        searchFoodVC.searchFoodPresenter?.router = AddFoodRouter()
        searchFoodVC.searchFoodPresenter?.searchFoodVC = searchFoodVC
        
        searchFoodNC.viewControllers = [searchFoodVC]
        
        return presenter
    }
    
}
