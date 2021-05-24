//
//  ApiCall.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 18/05/21.
//

import Foundation

struct API {
    static let baseUrl = "https://api.spoonacular.com/"
    static let APIKEY = "e1f65dc5b65a4d2991aaee052f814b2b"
}

protocol EndPoint {
    var url: String { get }
}

enum EndPoints {
    enum Gets: EndPoint {
        
        case search
        case recipeInformation
        case randomMenu
        
        
        public var url: String {
            switch self {
            
            case EndPoints.Gets.search: return ""
                
            case EndPoints.Gets.recipeInformation: return "\(API.baseUrl)"
                
            case EndPoints.Gets.randomMenu: return "\(API.baseUrl)recipes/complexSearch?query=pizza&maxFat=25&number=10&apiKey=\(API.APIKEY)"
           
        }
        
            
        }
    }
}
