//
//  DetailRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 17/06/21.
//

import Foundation
import UIKit

protocol DetailRouterDelegate {
    func createDetailModule()->UIViewController
}

class DetailRouter: DetailRouterDelegate {
    
    func createDetailModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailRecipeViewController") as DetailRecipeViewController
        
        let detailUseCase = Injection().provideHomeUseCase()
        let presenter = DetailPresenter(useCase: detailUseCase)
        
        detailVC.presenter = presenter
        detailVC.presenter?.router = HomeRouter()
        detailVC.presenter?.detailView = detailVC
        
        return detailVC
    }
    
}
