//
//  PlanMapper.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 02/08/21.
//

import Foundation

class PlanMapper {
    static func mapPlanEntityToPlanDomains(planEntities: [PlanEntity]) -> [PlanModel] {
        planEntities.map { planEntity in
            return
                PlanModel(dayCategory: planEntity.dayCategory, date: planEntity.date, listMenuModel: planEntity.listMenuEntity.map{ (menuEntity) in
                    return MenuModel(id: menuEntity.id, title: menuEntity.title, image: menuEntity.image, imageType: menuEntity.imageType, nutrition: menuEntity.nutrition.map{ (nutrientEntity) in
                        return NutrientModel(title: nutrientEntity.title, amount: nutrientEntity.amount, unit: nutrientEntity.unit)
                    }, summary: menuEntity.summary, extendedIngridients: [], isBookmarked: menuEntity.isBookmarked)
                })
        }
        
    }
    
    static func mapSinglePlanEntityToPlanDomains(planEntity: PlanEntity) -> PlanModel {
        return
            PlanModel(dayCategory: planEntity.dayCategory, date: planEntity.date, listMenuModel: planEntity.listMenuEntity.map{ (menuEntity) in
                return MenuModel(id: menuEntity.id, title: menuEntity.title, image: menuEntity.image, imageType: menuEntity.imageType, nutrition: menuEntity.nutrition.map{ (nutrientEntity) in
                    return NutrientModel(title: nutrientEntity.title, amount: nutrientEntity.amount, unit: nutrientEntity.unit)
                }, summary: menuEntity.summary, extendedIngridients: [], isBookmarked: menuEntity.isBookmarked)
            })
    }
    
    static func mapSinglePlanDomainToPlanEntity(planModel: PlanModel) -> PlanEntity {
        let planEntity = PlanEntity()
        planEntity.date = planModel.date!
        planEntity.dayCategory = planModel.dayCategory!
    
        _ = Array(planEntity.listMenuEntity)
        _ = planModel.listMenuModel?.map { menuModel in
            let menuEntity = MenuEntity()
            menuEntity.id = menuModel.id!
            menuEntity.title = menuModel.title!
            menuEntity.image = menuModel.image!
            menuEntity.imageType = menuModel.imageType!
        } as? [MenuEntity]
        
        return planEntity
    }
    
}


