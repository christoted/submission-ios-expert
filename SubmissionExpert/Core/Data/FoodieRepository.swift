//
//  FoodieRepository.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation
import Combine
import RealmSwift

protocol FoodieRepositoryProtocol {
    func getRandomMenu() -> AnyPublisher<[MenuModel], Error>
    
    // func getRecipeDetail(recipeId: Int) -> AnyPublisher<MenuDetailResponse, Error>
    
    func getRecipeDetailOffline(recipeId: Int)->AnyPublisher<MenuModel, Error>
    
    func updateToBookmarkMenu(recipeId: Int, isBookmarked: Bool)
    
    func getBookmarkedMenu()->AnyPublisher<[MenuModel], Error>
    
    //Search
    func getSearchMenu(recipeName: String)->AnyPublisher<[MenuModel], Error>
    
    //MARK:: Plan
    func insertPlan(from planModel: PlanModel) -> AnyPublisher<Bool, Error>
    
    func getPlan(byDate date: Date) -> AnyPublisher<[PlanModel], Error>
}


final class FoodieRepository: NSObject {
    typealias foodInstance = (RemoteDatasource, LocalDatasource) -> FoodieRepository
    
    let remote: RemoteDatasource
    let locale: LocalDatasource
    
    init(remoteDataSource: RemoteDatasource, localeDataSource: LocalDatasource) {
        self.remote = remoteDataSource
        self.locale = localeDataSource
    }
    
    static let instance: foodInstance = { remoteDataSource, localeDataSource in
        return FoodieRepository(remoteDataSource: remoteDataSource, localeDataSource: localeDataSource)
    }
}

extension FoodieRepository: FoodieRepositoryProtocol {
    
    func insertPlan(from planModel: PlanModel) -> AnyPublisher<Bool, Error> {
        //Need Plan Entity 
        self.locale.insertPlan(from: PlanMapper.mapSinglePlanDomainToPlanEntity(planModel: planModel))
    }
    
    func getPlan(byDate date: Date) -> AnyPublisher<[PlanModel], Error> {
        self.locale.getPlan(byDate: date).map {
            PlanMapper.mapPlanEntityToPlanDomains(planEntities: $0)
        }.eraseToAnyPublisher()
    }
    
    func getSearchMenu(recipeName: String) -> AnyPublisher<[MenuModel], Error> {
        self.remote.searchMenu(recipeName: recipeName).map {
            MenuMapper.mapCategoryResponseToEntity(input: $0)
        }.flatMap{ response in self.locale.getSearchMenu(by: recipeName)
            .flatMap{ (locale) -> AnyPublisher<[MenuModel], Error> in
                if response.count > locale.count {
                    return self.locale.insertSearchMenu(by: recipeName, from: response)
                        .filter{$0}
                        .flatMap{ _ in self.locale.getSearchMenu(by: recipeName)
                            .map{MenuMapper.mapCategoryEntityToDomains(input: $0)}
                        }.eraseToAnyPublisher()
                } else {
                    return self.locale.getSearchMenu(by: recipeName)
                        .map{MenuMapper.mapCategoryEntityToDomains(input: $0)}.eraseToAnyPublisher()
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func updateToBookmarkMenu(recipeId: Int, isBookmarked: Bool) {
        self.locale.updateFavorite(by: recipeId, isBookmarked: isBookmarked)
    }
    
    func getBookmarkedMenu() -> AnyPublisher<[MenuModel], Error> {
        return self.locale.getFavoriteMeals().map {
            MenuMapper.mapCategoryEntityToDomains(input: $0)
        }.eraseToAnyPublisher()
    }
    
    func getRecipeDetailOffline(recipeId: Int) -> AnyPublisher<MenuModel, Error> {
        return self.locale.getDetailMenu(recipeId: recipeId).flatMap { (result) -> AnyPublisher<MenuModel, Error> in
            
            if ( result.extendedIngredients.isEmpty) {
                return self.remote.getDetailMenu(recipeId: recipeId)
                    // Mapping
                    .map {
                        MenuDetailMapper.mapCategoryDetailResponseToEntity(by: recipeId, input: $0)
                    }
                    .flatMap {
                        self.locale.updateMenu(recipeId: recipeId, from: $0)
                    }
                    .filter {
                        $0
                    }
                    .flatMap{ _ in self.locale.getDetailMenu(recipeId: recipeId)
                        .map {
                            MenuDetailMapper.mapCategoryDetailEntityToDomains(input: $0)
                        }
                        
                    }.eraseToAnyPublisher()
                //Terus update dah
            }else {
                return self.locale.getDetailMenu(recipeId: recipeId).map {
                    MenuDetailMapper.mapCategoryDetailEntityToDomains(input: $0)
                }.eraseToAnyPublisher()
            }
            
        }.eraseToAnyPublisher()
    }
    
    
    func getRandomMenu() -> AnyPublisher<[MenuModel], Error> {
        
        return self.locale.getRandomMenu()
            .flatMap { (result) -> AnyPublisher<[MenuModel], Error> in
                if result.isEmpty {
                    return self.remote.getRandomMenu()
                        .map{
                            MenuMapper.mapCategoryResponseToEntity(input: $0)
                        }
                        .flatMap{
                            self.locale.insertRandomMenu(from: $0)
                        }
                        .filter{
                            $0
                        }
                        .flatMap { _ in self.locale.getRandomMenu()
                            .map{
                                MenuMapper.mapCategoryEntityToDomains(input: $0)
                            }
                        }.eraseToAnyPublisher()
                } else {
                    return self.locale.getRandomMenu()
                        .map{
                            MenuMapper.mapCategoryEntityToDomains(input: $0)
                        }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
}
