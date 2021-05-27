//
//  FoodieRepository.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation
import Combine

protocol FoodieRepositoryProtocol {
    func getRandomMenu() -> AnyPublisher<[RandomMenuResponse], Error>
    
    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error>
    
    
    
    func getRandomMenuOffline() -> AnyPublisher<[MenuModel], Error>
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
    func getRandomMenuOffline() -> AnyPublisher<[MenuModel], Error> {
        return self.locale.getRandomMenu()
            .flatMap { (result) -> AnyPublisher<[MenuModel], Error> in
                if result.isEmpty {
                    return self.remote.getRandomMenu()
                        .map{ (menuEntity) in
                            CategoryMapper.mapCategoryResponseToEntity(input: menuEntity)
                        }
                        .flatMap{ (menuEnti) in
                            self.locale.insertRandomMenu(from: menuEnti)
                        }
                        .filter{ (menuEnti) in
                            menuEnti
                        }
                        .flatMap { _ in self.locale.getRandomMenu()
                            .map{ (menuEnti) in
                                CategoryMapper.mapCategoryEntityToDomains(input: menuEnti)
                            }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getRandomMenu()
                        .map{ (menuEtity) in
                            CategoryMapper.mapCategoryEntityToDomains(input: menuEtity)
                        }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getRecipeDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error> {
        return self.remote.getDetailMenu(recipeId: recipeId)
    }
    
    func getRandomMenu() -> AnyPublisher<[RandomMenuResponse], Error> {
        return self.remote.getRandomMenu()
    }
    
    
  /*  func getRandomMenu() -> AnyPublisher<[MenuModel], Error> {
        return self.locale.getRandomMenu()
            .flatMap { (result) -> AnyPublisher<[MenuModel], Error> in
                if result.isEmpty {
                    return self.remote.getRandomMenu()
                        .map{
                            CategoryMapper.mapCategoryResponseToEntity(input: $0)
                        }
                        .flatMap{
                            self.locale.insertRandomMenu(from: $0, from: $1)
                        }
                        .filter{
                            $0
                        }
                        .flatMap { _ in self.locale.getRandomMenu()
                            .map{
                                CategoryMapper.mapCategoryEntitiesToDomains(input: $0)
                            }
                        }
                        
                } else {
                    return self.locale.getRandomMenu()
                        .map{
                            CategoryMapper.mapCategoryEntityToDomains(input: $0)
                        }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    } */
    
    
}
