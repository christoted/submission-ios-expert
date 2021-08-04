//
//  WeeklyRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 04/08/21.
//

import Foundation
import UIKit

class WeeklyRouter {
    func navigateToAddFoodModule()->AddFoodPresenter {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addFoodVC = storyboard.instantiateViewController(identifier: "addfoodvc") as AddFoodViewController
        
        let useCase = Injection().provideHomeUseCase()
        let presenter = AddFoodPresenter(useCase: useCase)
        
        addFoodVC.addFoodPresenter = presenter
        addFoodVC.addFoodPresenter?.weeklyRouter = WeeklyRouter()
        addFoodVC.addFoodPresenter?.viewController = addFoodVC
        
        return presenter
    }
}
