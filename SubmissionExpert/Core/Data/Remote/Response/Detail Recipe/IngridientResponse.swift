//
//  IngridientResponse.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 25/05/21.


import Foundation

struct IngridientResponse: Codable {
    let id: Int?
    let asile: String?
    let name: String?
    let original: String?
    let unit: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case asile = "asile"
        case name = "name"
        case original = "original"
        case unit = "unit"
    }
    
}
