//
//  PlanMapper.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 02/08/21.
//

import Foundation
import RealmSwift

class PlanMapper {
    static func mapPlanEntityToPlanDomains(planEntities: [PlanEntity]) -> [PlanModel] {
        planEntities.map { planEntity in
            return
                PlanModel(dayCategory: planEntity.dayCategory, date: planEntity.date, listMenuModel: planEntity.listMenuEntity.map{ (menuEntity) in
                    return MenuModel(id: menuEntity.id, title: menuEntity.title, image: menuEntity.image, imageType: menuEntity.imageType, nutrition: menuEntity.nutrition.map{ (nutrientEntity) in
                        return NutrientModel(title: nutrientEntity.title, amount: nutrientEntity.amount, unit: nutrientEntity.unit)
                    }, summary: menuEntity.summary, extendedIngridients: [], isBookmarked: menuEntity.isBookmarked)
                }, id: planEntity.id, foodListTitle: planEntity.foodListTitle)
        }
        
    }
    
    static func mapSinglePlanEntityToPlanDomains(planEntity: PlanEntity) -> PlanModel {
        return
            PlanModel(dayCategory: planEntity.dayCategory, date: planEntity.date, listMenuModel: planEntity.listMenuEntity.map{ (menuEntity) in
                return MenuModel(id: menuEntity.id, title: menuEntity.title, image: menuEntity.image, imageType: menuEntity.imageType, nutrition: menuEntity.nutrition.map{ (nutrientEntity) in
                    return NutrientModel(title: nutrientEntity.title, amount: nutrientEntity.amount, unit: nutrientEntity.unit)
                }, summary: menuEntity.summary, extendedIngridients: [], isBookmarked: menuEntity.isBookmarked)
            }, id: planEntity.id, foodListTitle: planEntity.foodListTitle)
    }
    
    static func mapSinglePlanDomainToPlanEntity(planModel: PlanModel) -> PlanEntity {
        
        let listMenuEntity = List<MenuEntity>()
        
        planModel.listMenuModel?.map { menuModel in
            let menuEntity = MenuEntity()
            menuEntity.id = menuModel.id!
            menuEntity.image = menuModel.image!
            menuEntity.title = menuModel.title!
            menuEntity.isBookmarked = menuModel.isBookmarked!
            menuEntity.imageType = menuModel.imageType!
            menuEntity.summary = menuModel.summary!
            
            listMenuEntity.append(menuEntity)
        }
        
        let planEntity = PlanEntity()
        planEntity.date = planModel.date!
        planEntity.dayCategory = planModel.dayCategory!
        planEntity.id = planModel.id!
        planEntity.listMenuEntity = listMenuEntity
        planEntity.foodListTitle = planModel.foodListTitle ?? ""

        
        return planEntity
    }

    
}


