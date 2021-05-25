//
//  RandomMenuResponse.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation

struct RandomMenuResponse: Codable {
    let id:Int?
    let title: String?
    let image: String?
    let imageType: String?
    let nutrition: Nutrients
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case image = "image"
        case imageType = "imageType"
        case nutrition = "nutrition"
    }
   
}

struct Nutrients: Codable {
    let nutrients: [NutrientsResponse]
    
    private enum CodingKeys: String, CodingKey {
        case nutrients = "nutrients"
    }
}

struct NutrientsResponse: Codable {
    let title: String?
    let amount: Double?
    let unit: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case amount = "amount"
        case unit = "unit"
    }
}
