//
//  AddFoodPresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 25/07/21.
//

import Foundation


class AddFoodPresenter {
    
    var useCase: RecipeUseCase?
    var addFoodRouter: AddFoodRouter?
    init(useCase: RecipeUseCase) {
        self.useCase = useCase
    }
}
