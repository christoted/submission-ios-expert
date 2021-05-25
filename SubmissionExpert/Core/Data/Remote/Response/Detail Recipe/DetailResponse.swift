//
//  DetailResponse.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 25/05/21.
//

import Foundation

class DetailResponse: Codable {
    
    let extendedIngredients: [IngridientResponse]?
    
    let id: Int?
    let title: String?
    let image: String?
    let summary: String?
    let dishTypes: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case extendedIngredients = "extendedIngredients"
        case id = "id"
        case title = "title"
        case image = "image"
        case summary = "summary"
        case dishTypes = "dishTypes"
    }
    
}
