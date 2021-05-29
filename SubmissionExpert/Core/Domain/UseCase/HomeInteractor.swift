//
//  HomeInteractor.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine


protocol HomeUseCase {
    func getRandomMenu() -> AnyPublisher<[MenuModel], Error >
    
    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error>
    
    func getRecipeDetailOffline(recipeId: Int) -> AnyPublisher<MenuDetailModel, Error>
}


class HomeInteractor : HomeUseCase {
  
    
  
    
    private let repository: FoodieRepositoryProtocol
    
    init(repositoryProtocol: FoodieRepositoryProtocol) {
        self.repository = repositoryProtocol
    }
  
    func getRandomMenu() -> AnyPublisher<[MenuModel], Error> {
        return repository.getRandomMenu()
    }

    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error> {
        repository.getRecipeDetail(recipeId: recipeId)
    }
    
    
    func getRecipeDetailOffline(recipeId: Int) -> AnyPublisher<MenuDetailModel, Error> {
        return repository.getRecipeDetailOffline(recipeId: recipeId)
    }
    
    
}
