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
    
  //  func getRecipeDetail(recipeId: Int) -> AnyPublisher<MenuDetailResponse, Error>
    
    func getRecipeDetailOffline(recipeId: Int) -> AnyPublisher<MenuModel, Error>
    
    func updateFavourite(recipeId: Int, isBookmakred: Bool)
    
    func getFavouriteMenu()->AnyPublisher<[MenuModel], Error>
    
    
}


class HomeInteractor : HomeUseCase {
 
    func getFavouriteMenu() -> AnyPublisher<[MenuModel], Error> {
        return repository.getBookmarkedMenu()
    }
    
    func updateFavourite(recipeId: Int, isBookmakred: Bool) {
        repository.updateToBookmarkMenu(recipeId: recipeId, isBookmarked: isBookmakred)
    }
    
  
    private let repository: FoodieRepositoryProtocol
    
    init(repositoryProtocol: FoodieRepositoryProtocol) {
        self.repository = repositoryProtocol
    }
  
    func getRandomMenu() -> AnyPublisher<[MenuModel], Error> {
        return repository.getRandomMenu()
    }

//    func getRecipeDetail(recipeId: Int) -> AnyPublisher<MenuDetailResponse, Error> {
//        repository.getRecipeDetail(recipeId: recipeId)
//    }
    
    
    func getRecipeDetailOffline(recipeId: Int) -> AnyPublisher<MenuModel, Error> {
        return repository.getRecipeDetailOffline(recipeId: recipeId)
    }
    
    
}
