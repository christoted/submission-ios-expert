//
//  HomePresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine

class HomePresenter: ObservableObject {
  
    private let useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }

    func getCategories() -> AnyPublisher<[RandomMenuResponse], Error > {
        return useCase.getRandomMenu()
    }
    
    func getRandomMenuOffline()-> AnyPublisher<[MenuModel], Error> {
        return useCase.getRandomMenuOffline()
    }
}
