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
    func getDetailMenu(recipeId: Int)->AnyPublisher<MenuEntity, Error>
    
    //Update Menu
    func updateMenu(recipeId: Int,from menuEntity: MenuEntity) -> AnyPublisher<Bool, Error>
    
    //Add Ingri
    func addIngridient(from ingridientEntity: ([IngridientEntity]))-> AnyPublisher<Bool, Error>
    
    //Nanti
    func updateFavorite(by idMeal: Int, isBookmarked: Bool)
    
    func getFavoriteMeals() -> AnyPublisher<[MenuEntity], Error>
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
   
    func getFavoriteMeals() -> AnyPublisher<[MenuEntity], Error> {
        return Future<[MenuEntity], Error> { completion in
            
            if let realMDBSave = self.realm {
                let menuBookmarked: Results<MenuEntity> = {
                    realMDBSave.objects(MenuEntity.self).filter("isBookmarked == true").sorted(byKeyPath: "title", ascending: true)
                }()
                
                completion(.success(menuBookmarked.toArray(ofType: MenuEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    
    func updateFavorite(by idMeal: Int, isBookmarked: Bool) {
       
            if let realmDB = self.realm, let menuEntitySave = {
                realmDB.objects(MenuEntity.self).filter("id == \(idMeal)")
            }().first {
                do {
                    try realmDB.write {
                        menuEntitySave.setValue(isBookmarked, forKey: "isBookmarked")
                    }
                    
                } catch {
                   
                }
            } else {
              
            }
            
    }
    
    func updateMenu(recipeId: Int, from menuEntity: MenuEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            
            if let realmDB = self.realm, let menuEntitySave = {
                realmDB.objects(MenuEntity.self).filter("id == \(recipeId)")
            }().first {
                do {
                    try realmDB.write{
                        menuEntitySave.setValue(menuEntity.summary, forKey: "summary")
                        menuEntitySave.setValue(menuEntity.extendedIngredients, forKey: "extendedIngredients")
//                        menuEntity.setValue(menuEntity.nutrition, forKey: "nutrition")
                    }
                    
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    

    func addIngridient(from ingridientEntity: ([IngridientEntity])) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realmDB = self.realm {
                do {
                    try realmDB.write {
                        realmDB.add(ingridientEntity)
                    }
                    
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    
    func getDetailMenu(recipeId: Int) -> AnyPublisher<MenuEntity, Error> {
        return Future<MenuEntity, Error> { completion in
            if let realmDB = self.realm {
                let menu: Results<MenuEntity> = {
                    realmDB.objects(MenuEntity.self)
                        .filter("id == \(recipeId)")
                }()
                
                guard let menuSafe = menu.first else {
                    return
                }
                
                completion(.success(menuSafe))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    
   
    
    // Maybe dihapus
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
