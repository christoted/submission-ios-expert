//
//  MenuDetailRes.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 02/06/21.
//

import Foundation

struct MenuDetailResponse: Codable {
    
    let extendedIngredients: [IngridientResponse]?
    
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
    let summary: String?
    let dishTypes: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case extendedIngredients = "extendedIngredients"
        case id = "id"
        case title = "title"
        case image = "image"
        case imageType = "imageType"
        case summary = "summary"
        case dishTypes = "dishTypes"
    }
    
}
