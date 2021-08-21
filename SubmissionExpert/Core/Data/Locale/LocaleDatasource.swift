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
    
    //Update fav
    func updateFavorite(by idMeal: Int, isBookmarked: Bool)
    
    func getFavoriteMeals() -> AnyPublisher<[MenuEntity], Error>
    
    //Search
    func insertSearchMenu(by recipeName: String, from menuEntities: [MenuEntity]) -> AnyPublisher<Bool, Error>
    
    func getSearchMenu(by recipeName: String) -> AnyPublisher<[MenuEntity], Error>
    
    //MARK:: Plan
    func insertPlan(from planEntity: PlanEntity) -> AnyPublisher<Bool, Error>
    
    func getPlan(byDate date: String)->AnyPublisher<[PlanEntity], Error>
    
    func updateCheckmark(by idPlanEntity: Int, isCheckmarked: Bool)
    
    func deletePlanEntity(by idPlanEntity: Int)
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
    
    func deletePlanEntity(by idPlanEntity: Int) {
        // query all objects where the id in not included
        guard let realmDB = self.realm else {
            return
        }
        let objectsToDelete = realmDB.objects(PlanEntity.self).filter("id == \(idPlanEntity)")
        
        do {
            try realmDB.write {
                realmDB.delete(objectsToDelete)
                print("Success delete")
            }
        } catch {
            print("Cannot delete")
        }
        
      
    }
    
    func updateCheckmark(by idPlanEntity: Int, isCheckmarked: Bool) {
        if let realmDB = self.realm, let planEntitySave = {
            realmDB.objects(PlanEntity.self).filter("id == \(idPlanEntity)")
        }().first {
            do {
                try realmDB.write {
                    planEntitySave.setValue(isCheckmarked, forKey: "isChecked")
                    print("Success")
                    print("localdataource \(idPlanEntity) \(isCheckmarked)")
                }
            } catch {
                print("Error")
            }
        } else {
            print("Fail update checkmarked")
        }
    }
    
    //MARK:: Plan
    func insertPlan(from planEntity: PlanEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realmDB = self.realm {
                do {
                    try realmDB.write {
                        realmDB.add(planEntity, update: .all)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getPlan(byDate date: String) -> AnyPublisher<[PlanEntity], Error> {
        return Future<[PlanEntity], Error> { completion in
            if let realmDB = self.realm {
                let planEntities: Results<PlanEntity> = {
                    realmDB.objects(PlanEntity.self)
                        .filter("date == %@", date)
                }()
                
                completion(.success(planEntities.toArray(ofType: PlanEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func insertSearchMenu(by recipeName: String, from menuEntities: [MenuEntity]) ->AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realmDB = self.realm {
                do {
                    try realmDB.write {
                        for menu in menuEntities {
                            if let menuEntity = realmDB.object(ofType: MenuEntity.self, forPrimaryKey: menu.id) {
                                if menu.title == menuEntity.title {
                                    menu.isBookmarked = menuEntity.isBookmarked
                                    realmDB.add(menu, update: .all)
                                } else {
                                    realmDB.add(menu)
                                }
                            } else {
                                realmDB.add(menu)
                            }
                        }
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
    
    func getSearchMenu(by recipeName: String) -> AnyPublisher<[MenuEntity], Error> {
        return Future<[MenuEntity], Error> { completion in
            if let realmDBSave = self.realm {
                let resultSearchMenu: Results<MenuEntity> =  {
                    realmDBSave.objects(MenuEntity.self).filter("title contains[c] %@", recipeName).sorted(byKeyPath: "title", ascending: true)
                }()
                
                completion(.success(resultSearchMenu.toArray(ofType: MenuEntity.self)))
                
            } else {
                
                completion(.failure(DatabaseError.invalidInstance))
            }
            
        }.eraseToAnyPublisher()
    }
    
    
    
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
                        .filter("title contains[c] %@", "Pizza")
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
