//
//  Menu.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation

struct MenuModel {
    let id:Int?
    let title: String?
    let image: String?
    let imageType: String?
    let nutrition: [NutrientModel]
    
}


struct NutrientModel  {
    let title: String?
    let amount: Double?
    let unit: String?
    
    
}
