//
//  SearchFoodNavigationController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 25/07/21.
//

import UIKit

class SearchFoodNavigationController: UINavigationController {
    
    var searchFoodController: SearchFoodViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchFoodController = SearchFoodViewController()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
