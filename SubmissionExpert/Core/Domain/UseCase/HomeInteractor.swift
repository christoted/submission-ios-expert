//
//  HomeInteractor.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine


protocol HomeUseCase {
    func getRandomMenu() -> AnyPublisher<[RandomMenuResponse], Error >
}


class HomeInteractor : HomeUseCase {

    private let repository: FoodieRepositoryProtocol
    
    init(repositoryProtocol: FoodieRepositoryProtocol) {
        self.repository = repositoryProtocol
    }
    
    func getRandomMenu() -> AnyPublisher<[RandomMenuResponse], Error> {
        return repository.getRandomMenu()
    }
    
    
}
