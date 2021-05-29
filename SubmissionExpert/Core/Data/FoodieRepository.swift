//
//  FoodieRepository.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation
import Combine

protocol FoodieRepositoryProtocol {
    func getRandomMenu() -> AnyPublisher<[MenuModel], Error>

    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error>
    
    func getRecipeDetailOffline(recipeId: Int)->AnyPublisher<MenuDetailModel, Error>
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
    func getRecipeDetailOffline(recipeId: Int) -> AnyPublisher<MenuDetailModel, Error> {
        
        return self.locale.getDetailMenu(recipeId: recipeId).flatMap { (result) -> AnyPublisher<MenuDetailModel, Error> in
            if result.title.isEmpty {
                print("TEST")
                return self.remote.getDetailMenu(recipeId: recipeId)
                    .map{
                        CategoryMapper.mapCategoryDetailResponseToEntity(input: $0)
                    }
                    .flatMap {
                        self.locale.insertDetailMenu(from: $0)
                    }
                    .filter{
                        $0
                    }
                    .flatMap { _ in self.locale.getDetailMenu(recipeId: recipeId)
                        .map{
                            CategoryMapper.mapCategoryDetailEntityToDomains(input: $0)
                        }
                        
                    }.eraseToAnyPublisher()
                
                
            } else {
                print("TEST BAWAH")
                return self.locale.getDetailMenu(recipeId: recipeId)
                    .map{
                        CategoryMapper.mapCategoryDetailEntityToDomains(input: $0)
                    }.eraseToAnyPublisher()
                    
            }
        }.eraseToAnyPublisher()
    }
    
 
    
   
    

    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error> {
        return self.remote.getDetailMenu(recipeId: recipeId)
    }

    func getRandomMenu() -> AnyPublisher<[MenuModel], Error> {

        return self.locale.getRandomMenu()
            .flatMap { (result) -> AnyPublisher<[MenuModel], Error> in
                if result.isEmpty {
                    return self.remote.getRandomMenu()
                        .map{
                            CategoryMapper.mapCategoryResponseToEntity(input: $0)
                        }
                        .flatMap{
                            self.locale.insertRandomMenu(from: $0)
                        }
                        .filter{
                            $0
                        }
                        .flatMap { _ in self.locale.getRandomMenu()
                            .map{
                                CategoryMapper.mapCategoryEntityToDomains(input: $0)
                            }
                        }.eraseToAnyPublisher()
                } else {
                    return self.locale.getRandomMenu()
                        .map{
                            CategoryMapper.mapCategoryEntityToDomains(input: $0)
                        }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
      }
}
