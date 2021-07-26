//
//  SearchFoodPresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import Foundation
import UIKit
import Combine

class SearchFoodPresenter: ObservableObject {
    
    private let useCase: RecipeUseCase
    var searchFoodVC: SearchFoodViewController?
    var router: AddFoodRouter?
    
    init(useCase: RecipeUseCase) {
        self.useCase = useCase
    }
    
    func getInitFood()-> AnyPublisher<[MenuModel], Error>{
        return useCase.getRandomMenu()
    }
    
    func searchFood(recipeName: String)->AnyPublisher<[MenuModel], Error> {
        return useCase.getSearchMenuByName(recipeName: recipeName)
    }
    
}
