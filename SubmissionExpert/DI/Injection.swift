//
//  Injection.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import RealmSwift

class Injection {
    func provideRepository() -> FoodieRepositoryProtocol {
        
        let realm: Realm? = try? Realm()
        
        let remoteDataSource: RemoteDatasource = RemoteDatasource.sharedRemoteDatasourceInstance
        let localDataSource: LocalDatasource = LocalDatasource.sharedInstance(realm)
        
        
        return FoodieRepository(remoteDataSource: remoteDataSource, localeDataSource: localDataSource)
    }
    
    func provideHomeUseCase()-> RecipeUseCase {
        
        let repository = provideRepository()
    
        return RecipeInteractor(repositoryProtocol: repository)
    }
    
    
    
    
}
