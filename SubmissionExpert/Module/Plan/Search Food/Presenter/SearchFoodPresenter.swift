//
//  SearchFoodPresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import Foundation
import UIKit
import Combine

class SearchFoodPresenter: ObservableObject {
    
    private let useCase: RecipeUseCase
    
    
    init(useCase: RecipeUseCase) {
        self.useCase = useCase
    }
    
}
