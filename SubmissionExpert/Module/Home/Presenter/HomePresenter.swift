//
//  HomePresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine
import UIKit

class HomePresenter: ObservableObject {
  
    private let useCase: HomeUseCase
    var homeRouter:HomeRouter?
    var homeView: UIViewController?
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
        
    }
    func getCategories() -> AnyPublisher<[MenuModel], Error > {
        return useCase.getRandomMenu()
    }
    

    
}
