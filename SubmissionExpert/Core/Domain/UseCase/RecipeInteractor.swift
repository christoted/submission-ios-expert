//
//  HomeInteractor.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine


protocol RecipeUseCase {
    func getRandomMenu() -> AnyPublisher<[MenuModel], Error >
    
  //  func getRecipeDetail(recipeId: Int) -> AnyPublisher<MenuDetailResponse, Error>
    
    func getRecipeDetailOffline(recipeId: Int) -> AnyPublisher<MenuModel, Error>
    
    func updateFavourite(recipeId: Int, isBookmakred: Bool)
    
    func getFavouriteMenu()->AnyPublisher<[MenuModel], Error>
    
    func getSearchMenuByName(recipeName: String) -> AnyPublisher<[MenuModel],Error>
    
    //MARK:: Plan
    func insertPlan(planEntity: PlanModel)->AnyPublisher<Bool, Error>
    
    func getPlanByDate(date: String)->AnyPublisher<[PlanModel], Error>
    
    func updateCheckmark(idPlan: Int, isCheckmarked: Bool)
    
    func deletePlanEntity(idPlan:Int)
}


class RecipeInteractor : RecipeUseCase {
    func deletePlanEntity(idPlan: Int) {
        repository.deletePlanEntity(idPlan: idPlan)
    }
    
    
    func updateCheckmark(idPlan: Int, isCheckmarked: Bool) {
        return repository.updateCheckmark(idPlan: idPlan, isCheckmarked: isCheckmarked)
    }
    
    
    func insertPlan(planEntity: PlanModel) -> AnyPublisher<Bool, Error> {
        return repository.insertPlan(from: planEntity)
    }
    
    func getPlanByDate(date: String) -> AnyPublisher<[PlanModel], Error> {
        return repository.getPlan(byDate: date)
    }
    
    
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
    
    //Search
    func getSearchMenuByName(recipeName: String) -> AnyPublisher<[MenuModel], Error> {
        return repository.getSearchMenu(recipeName: recipeName)
    }
    
    
    
}
