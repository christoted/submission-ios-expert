//
//  CategoryMapper.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation


class MenuMapper {
    
    static func mapCategoryResponseToDomains(input randomMenuResponse: [RandomMenuResponse]) -> [MenuModel] {
        
        randomMenuResponse.map { menuResponse  in
            return MenuModel(id: menuResponse.id, title: menuResponse.title , image: menuResponse.image , imageType: menuResponse.imageType, nutrition: menuResponse.nutrition.nutrients.map { result in
                return NutrientModel(title: result.title, amount: result.amount, unit: result.unit)
            }, summary: "", extendedIngridients: [])
        }
        
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
    
 
    
 
    static func mapCategoryEntityToDomains(input menuEntities: [MenuEntity])-> [MenuModel]{
        menuEntities.map { menuEntities  in
            return MenuModel(id: menuEntities.id, title: menuEntities.title, image: menuEntities.image, imageType: menuEntities.imageType, nutrition: menuEntities.nutrition.map { result in
                return NutrientModel(title: result.title, amount: result.amount, unit: result.unit)
            }, summary: "", extendedIngridients: [])
        }
    }
  
    
 
    
}
