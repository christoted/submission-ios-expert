//
//  AddFoodPresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 25/07/21.
//

import Foundation


class AddFoodPresenter {
    
    var useCase: RecipeUseCase?
    var weeklyRouter: WeeklyRouter?
    var viewController: AddFoodViewController?
    init(useCase: RecipeUseCase) {
        self.useCase = useCase
    }
    
    func addToPlanDB(planEntity: PlanModel) {
        useCase?.insertPlan(planEntity: planEntity)
    }    
}
