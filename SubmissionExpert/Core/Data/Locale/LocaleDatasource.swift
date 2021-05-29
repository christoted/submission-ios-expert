//
//  LocaleDatasource.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine
import RealmSwift

protocol LocalDatasourceProtocol {
    func getRandomMenu()->AnyPublisher<[MenuEntity], Error>
    
    func insertRandomMenu(from menuEntity: [MenuEntity])-> AnyPublisher<Bool, Error>
    
    //For Detail
    func getDetailMenu(recipeId: Int)->AnyPublisher<MenuDetailEntity, Error>
    
    //Insert
    func insertDetailMenu(from menuEntity: MenuDetailEntity) -> AnyPublisher<Bool, Error>
}

class LocalDatasource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocalDatasource = {
        realmDatabase in return LocalDatasource(realm: realmDatabase)
    }
}

extension LocalDatasource: LocalDatasourceProtocol {
  
    func getDetailMenu(recipeId: Int) -> AnyPublisher<MenuDetailEntity, Error> {
        return Future<MenuDetailEntity, Error> { completion in
            if let realmDB = self.realm {
                let menus: Results<MenuDetailEntity> = {
                    realmDB.objects(MenuDetailEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                
                guard let menu = menus.first else {
                    return
                }
                
                completion(.success(menu))
                
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    
    func insertDetailMenu(from menuDetailEntities: MenuDetailEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realmDB = self.realm {
                do {
                    try realmDB.write {
                    
                            realmDB.add(menuDetailEntities)
                        
                    }
                    
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    
    func getRandomMenu() -> AnyPublisher<[MenuEntity], Error> {
        return Future<[MenuEntity], Error> { completion in
            if let realmDB = self.realm {
                let menus: Results<MenuEntity> = {
                    realmDB.objects(MenuEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                
                completion(.success(menus.toArray(ofType: MenuEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    
    func insertRandomMenu(from menuEntities: [MenuEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            
            
            if let realmDB = self.realm {
                do {
                    try realmDB.write{
                        for menuEntity in menuEntities{
                          //  menuEntity.nutrition = nutrientEntities
                            
                            //Add
                            realmDB.add(menuEntity, update: .all)
                        }
                        
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
                
            }
            
        }.eraseToAnyPublisher()
    }
    
    
}


extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        
        return array
    }
    
   
}
