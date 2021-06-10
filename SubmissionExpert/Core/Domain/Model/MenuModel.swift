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
    
    //Addition
    let summary: String?
    let extendedIngridients: [IngridientModel]?
    
}

struct NutrientModel  {
    let title: String?
    let amount: Double?
    let unit: String?
    
}


struct IngridientModel {
    let id: Int?
    let asile: String?
    let name: String?
    let original: String?
    let unit: String?
}



