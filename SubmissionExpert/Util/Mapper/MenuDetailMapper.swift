//
//  MenuDetailMapper.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 02/06/21.
//

import Foundation

class MenuDetailMapper {
    
    static func mapCategoryDetailResponseToDomains(input detailMenuResponse: MenuDetailResponse) -> MenuModel {
        
        return MenuModel(id: detailMenuResponse.id, title: detailMenuResponse.title, image: detailMenuResponse.image, imageType: detailMenuResponse.imageType, nutrition: [],
                         summary: "", extendedIngridients: detailMenuResponse.extendedIngredients!.map {
                            (response) in
                            return IngridientModel(id: response.id, asile: response.asile, name: response.name, original: response.original, unit: response.unit)
                         })
    }
    
    static func mapCategoryDetailResponseToEntity(by recipeId: Int,input menuDetailResponse: MenuDetailResponse) -> MenuEntity {
     
            let menuEntity = MenuEntity()
            
            menuEntity.id = menuDetailResponse.id!
            menuEntity.image = menuDetailResponse.image!
            menuEntity.summary = menuDetailResponse.summary!
            menuEntity.title = menuDetailResponse.title!
          //  menuEntity.dishTypes = menuDetailResponse.dishTypes!
            
            menuEntity.extendedIngredients =   menuDetailResponse.extendedIngredients!.map { (response)  in
                let ingEntity = IngridientEntity()
                ingEntity.id = response.id ?? 10
                ingEntity.asile = response.asile ?? ""
                ingEntity.name = response.name! ?? ""
                ingEntity.original = response.original ?? ""
                ingEntity.unit = response.unit ?? ""
                
                return ingEntity
            }
                
            
            return menuEntity
        
    }
    
    
    static func mapCategoryDetailEntityToDomains(input detailEntities: MenuEntity) -> MenuModel {
        return MenuModel(id: detailEntities.id, title: detailEntities.title, image: detailEntities.image, imageType: detailEntities.imageType, nutrition: detailEntities.nutrition.map{ (entity) in
            return NutrientModel(title: entity.title, amount: entity.amount, unit: entity.unit)
            
        }, summary: detailEntities.summary, extendedIngridients: detailEntities.extendedIngredients.map{ (entity) in
            return IngridientModel(id: entity.id, asile: entity.asile, name: entity.name, original: entity.original, unit: entity.unit)
        })
    }
    
 
    
}
