//
//  HomePresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine
import UIKit

class HomePresenter: ObservableObject {
  
    private let useCase: RecipeUseCase
    var homeRouter:HomeRouter?
    var homeView: UIViewController?
    
    init(useCase: RecipeUseCase, homeRouter: HomeRouter) {
        self.useCase = useCase
        self.homeRouter = homeRouter
    }
    func getCategories() -> AnyPublisher<[MenuModel], Error > {
        return useCase.getRandomMenu()
    }
    
    func getSearchCategories(foodTitle: String) -> AnyPublisher<[MenuModel], Error> {
        return useCase.getSearchMenuByName(recipeName: foodTitle)
    }

    
}
