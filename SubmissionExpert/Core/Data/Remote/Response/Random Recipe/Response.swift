//
//  Response.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation

struct Response: Codable {
    let result: [RandomMenuResponse]
    let offset: Int?
    let number: Int?
    let totalResults: Int?
    
    private enum CodingKeys: String, CodingKey {
        case result = "results"
        case offset = "offset"
        case number = "number"
        case totalResults = "totalResults"
    }
}
