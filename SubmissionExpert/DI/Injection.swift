//
//  Injection.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import RealmSwift

class Injection {
    private func provideRepository() -> FoodieRepositoryProtocol {
        
        let realm: Realm? = try? Realm()
        
        let remoteDataSource: RemoteDatasource = RemoteDatasource.sharedRemoteDatasourceInstance
        let localDataSource: LocalDatasource = LocalDatasource.sharedInstance(realm)
        
        
        return FoodieRepository(remoteDataSource: remoteDataSource, localeDataSource: localDataSource)
    }
    
    private func provideHomeUseCase()-> HomeUseCase {
        
        let repository = provideRepository()
    
        return HomeInteractor(repositoryProtocol: repository)
    }
    
    
}
