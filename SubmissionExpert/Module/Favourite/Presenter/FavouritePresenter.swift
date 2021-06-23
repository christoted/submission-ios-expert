//
//  FavouritePresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 10/06/21.
//

import Foundation
import Combine

class FavouritePresenter: ObservableObject {
    private let useCase: HomeUseCase
    var favRouter: FavoriteRouter?
    var favView: FavouriteViewController?
    
    init(useCase: HomeUseCase, favRouter: FavoriteRouter) {
        self.useCase = useCase
        self.favRouter = favRouter
    }
    
    func getBookmarkedMenu()->AnyPublisher<[MenuModel], Error> {
        return useCase.getFavouriteMenu()
    }
    
    
}
