//
//  CategoryMapper.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation

class CategoryMapper {
    
    static func mapCategoryResponseToDomains(input randomMenuResponse: [RandomMenuResponse]) -> [MenuModel] {
        
        randomMenuResponse.map { menuResponse  in
            return MenuModel(id: menuResponse.id, title: menuResponse.title , image: menuResponse.image , imageType: menuResponse.imageType, nutrition: menuResponse.nutrition.nutrients.map { result in
                return NutrientModel(title: result.title, amount: result.amount, unit: result.unit)
            })
        }
        
    }
    
    static func mapCategoryDetailResponseToDomains(input detailMenuResponse: DetailResponse) -> MenuDetailModel {
        
        return MenuDetailModel(id: detailMenuResponse.id!, title: detailMenuResponse.title, image: detailMenuResponse.image, summary: detailMenuResponse.summary, extendedIngredients: detailMenuResponse.extendedIngredients?.map({ (ingridientResponse)  in
                return IngridientModel(id: ingridientResponse.id, asile: ingridientResponse.asile, name: ingridientResponse.name, original: ingridientResponse.original, unit: ingridientResponse.unit)
            }
            
            ))
        
        
    }
    
    static func mapCategoryResponseToEntity(input menuResponse: [RandomMenuResponse])-> [MenuEntity] {
        
        menuResponse.map { menuResponse in
            let menuEntity = MenuEntity()
            
            guard let menuId = menuResponse.id, let menuTitle = menuResponse.title,
                  let menuImage = menuResponse.image, let menuImageType = menuResponse.imageType
            
            else {
                return menuEntity
            }
            
            
            menuEntity.id = menuId
            menuEntity.title = menuTitle
            menuEntity.image = menuImage
            menuEntity.imageType = menuImageType
            menuEntity.nutrition = menuResponse.nutrition.nutrients.map{ result in
                let nutrientEntity = NutrientsEntity()
                
                guard let title = result.title, let amount = result.amount, let unit = result.unit
                else {
                    return nutrientEntity
                }
                
                nutrientEntity.title = title
                nutrientEntity.amount = amount
                nutrientEntity.unit = unit
                
                
                return nutrientEntity
            }
 
            
            return menuEntity
        }
        
    }
    
    static func mapCategoryDetailResponseToEntity(input menuDetailResponse: DetailResponse) -> MenuDetailEntity {
     
            let menuEntity = MenuDetailEntity()
            
            menuEntity.id = menuDetailResponse.id!
            menuEntity.image = menuDetailResponse.image!
            menuEntity.summary = menuDetailResponse.summary!
            menuEntity.title = menuDetailResponse.title!
          //  menuEntity.dishTypes = menuDetailResponse.dishTypes!
            
            menuEntity.extendedIngredients =   menuDetailResponse.extendedIngredients!.map { (response)  in
                let ingEntity = IngridientEntity()
                ingEntity.id = response.id!
                ingEntity.asile = response.asile!
                ingEntity.name = response.name!
                ingEntity.original = response.original!
                ingEntity.unit = response.unit!
                
                return ingEntity
            }
                
            
            return menuEntity
        
    }
    
 
    static func mapCategoryEntityToDomains(input menuEntities: [MenuEntity])-> [MenuModel]{
        menuEntities.map { menuEntities  in
            return MenuModel(id: menuEntities.id, title: menuEntities.title, image: menuEntities.image, imageType: menuEntities.imageType, nutrition: menuEntities.nutrition.map { result in
                return NutrientModel(title: result.title, amount: result.amount, unit: result.unit)
            })
        }
    }
    
    static func mapCategoryDetailEntityToDomains(input detailEntities: MenuDetailEntity) -> MenuDetailModel {
        return MenuDetailModel(id: detailEntities.id, title: detailEntities.title, image: detailEntities.image, summary: detailEntities.summary, extendedIngredients: detailEntities.extendedIngredients.map { entities in
            return IngridientModel(id: entities.id, asile: entities.asile, name: entities.name, original: entities.original, unit: entities.unit)
            
        })
    }
    
    
}
