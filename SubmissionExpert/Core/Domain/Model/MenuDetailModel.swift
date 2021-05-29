//
//  MenuDetailModel.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 28/05/21.
//

import Foundation

struct MenuDetailModel {
    
    let id: Int?
    let title: String?
    let image: String?
    let summary: String?
   // let dishTypes: [String]?
    let extendedIngredients: [IngridientModel]?
}


struct IngridientModel {
    let id: Int?
    let asile: String?
    let name: String?
    let original: String?
    let unit: String?
}
