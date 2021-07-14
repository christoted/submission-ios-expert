//
//  SearchPresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 11/07/21.
//

import Foundation
import Combine

class SearchPresenter: ObservableObject {
    private let useCase: HomeUseCase
    var searchRouter: SearchRouter?
    var searchViewController: SearchViewController?
    
    init(useCase: HomeUseCase, searchRouter: SearchRouter) {
        self.useCase = useCase
        self.searchRouter = searchRouter
    }
    
    func getSearchMenu(recipeName: String) -> AnyPublisher<[MenuModel], Error> {
        return useCase.getSearchMenuByName(recipeName: recipeName)
    }
    
}
