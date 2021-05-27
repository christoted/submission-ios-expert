//
//  HomeInteractor.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine


protocol HomeUseCase {
    func getRandomMenu() -> AnyPublisher<[RandomMenuResponse], Error >
    
    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error>
    
    func getRandomMenuOffline() -> AnyPublisher<[MenuModel], Error>
}


class HomeInteractor : HomeUseCase {
    func getRandomMenuOffline() -> AnyPublisher<[MenuModel], Error> {
        return repository.getRandomMenuOffline()
    }
    
  
    private let repository: FoodieRepositoryProtocol
    
    init(repositoryProtocol: FoodieRepositoryProtocol) {
        self.repository = repositoryProtocol
    }
  
    func getRandomMenu() -> AnyPublisher<[RandomMenuResponse], Error> {
        return repository.getRandomMenu()
    }
    
    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error> {
        repository.getRecipeDetail(recipeId: recipeId)
    }
    
    
}
