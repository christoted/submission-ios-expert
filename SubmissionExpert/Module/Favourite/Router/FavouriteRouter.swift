//
//  FavouriteRouter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 17/06/21.
//

import Foundation
import UIKit

protocol FavouriteRouterDelegate {
    func createFavouriteModule()->UIViewController
}

class FavoriteRouter: FavouriteRouterDelegate {
    
    func createFavouriteModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let favVC = storyboard.instantiateViewController(identifier: "FavouriteViewController") as! FavouriteViewController
        
        let favUseCase = Injection().provideHomeUseCase()
        let presenter = FavouritePresenter(useCase: favUseCase, favRouter: FavoriteRouter())
        
        favVC.presenter = presenter
        favVC.presenter?.favRouter = FavoriteRouter()
        favVC.presenter?.favView = favVC
        
        return favVC
    }
    
    
}
