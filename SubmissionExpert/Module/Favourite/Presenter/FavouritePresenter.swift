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
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getBookmarkedMenu()->AnyPublisher<[MenuModel], Error> {
        return useCase.getFavouriteMenu()
    }
    
    
}
