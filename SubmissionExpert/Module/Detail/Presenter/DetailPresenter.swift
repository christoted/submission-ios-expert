//
//  DetailPresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/05/21.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
    private let useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getDetail(recipeId: Int) -> AnyPublisher<DetailResponse, Error> {
        return useCase.getRecipeDetail(recipeId: recipeId)
    }
    
    func getDetailOffline(recipeId: Int)-> AnyPublisher<MenuDetailModel, Error> {
        return useCase.getRecipeDetailOffline(recipeId: recipeId)
    }
}
