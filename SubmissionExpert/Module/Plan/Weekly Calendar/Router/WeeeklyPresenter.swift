//
//  WeeeklyPresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 04/08/21.
//

import Foundation
import Combine

class WeeklyPresenter {
    var useCase: RecipeUseCase?
    var router: MonthlyCalendarRouter?
    var controller: WeeklyViewController?
    
    init(useCase: RecipeUseCase) {
        self.useCase = useCase
    }
    
    func getFoodPlanByDate(date: String)->AnyPublisher<[PlanModel], Error> {
        return (useCase?.getPlanByDate(date: date))!
    }
    
    func updateCheckmarked(idPlan: Int, isCheckmarked: Bool)  {
        useCase?.updateCheckmark(idPlan: idPlan, isCheckmarked: isCheckmarked)
    }
}
