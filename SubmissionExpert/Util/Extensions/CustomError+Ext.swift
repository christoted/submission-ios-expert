//
//  CustomError+Ext.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation

enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)
    
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server responsed invalid"
        case .addressUnreachable(let url): return "\(url.absoluteString) Unreable"
        }
    }
}

enum DatabaseError: LocalizedError {
    case invalidInstance
    case requestFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance:
            return "Database can't intstance"
        case .requestFailed:
            return "Your request Failed."
        }
    }
}
