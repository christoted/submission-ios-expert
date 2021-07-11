//
//  HomeRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 17/06/21.
//

import Foundation
import UIKit

//Implement with Protocol Delegate
protocol HomeRouterDelegate  {
    func makeHomeView()
}


class HomeRouter {
    func makeDetailView() {
      let homeUseCase = Injection().provideHomeUseCase()
      let presenter = HomePresenter(useCase: homeUseCase)
        
        
      
    }
}
