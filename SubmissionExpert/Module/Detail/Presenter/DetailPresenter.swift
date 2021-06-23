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
    var router: HomeRouter?
    var detailView: DetailRecipeViewController?
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
//    func getDetail(recipeId: Int) -> AnyPublisher<MenuDetailResponse, Error> {
//        return useCase.getRecipeDetail(recipeId: recipeId)
//    }
    
    func getDetailOffline(recipeId: Int)-> AnyPublisher<MenuModel, Error> {
        return useCase.getRecipeDetailOffline(recipeId: recipeId)
    }
    
    func updateToBookmarkedMenu(recipeId: Int, isBookmarked: Bool) {
        useCase.updateFavourite(recipeId: recipeId , isBookmakred: isBookmarked)
    }
    
    func getBookmarkedMenu() -> AnyPublisher<[MenuModel], Error> {
        return useCase.getFavouriteMenu()
    }
}
