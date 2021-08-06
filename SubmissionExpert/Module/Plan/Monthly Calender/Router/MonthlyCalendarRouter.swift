//
//  MonthlyCalendarRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import Foundation
import UIKit

protocol MonthyCalendarRouterDelgate {
    
}

class MonthlyCalendarRouter {
    func navigateToWeeklyModule()->WeeklyPresenter {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let weeklyVC = storyboard.instantiateViewController(identifier: "weeklyviewcontroller") as WeeklyViewController
        
        let useCase = Injection().provideHomeUseCase()
        let presenter = WeeklyPresenter(useCase: useCase)
        
        weeklyVC.weeklyPresenter = presenter
        weeklyVC.weeklyPresenter?.router = MonthlyCalendarRouter()
        weeklyVC.weeklyPresenter?.controller = weeklyVC
        
        return presenter
    }
}

