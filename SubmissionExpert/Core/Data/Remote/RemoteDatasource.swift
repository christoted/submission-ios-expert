//
//  RemoteDatasource.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDatasourceProtocol: AnyObject {
    func getRandomMenu()->AnyPublisher<[RandomMenuResponse], Error>
    
    func getDetailMenu(recipeId: Int)->AnyPublisher<MenuDetailResponse, Error>
}

final class RemoteDatasource: NSObject{
    private override init() { }
    
    static let sharedRemoteDatasourceInstance: RemoteDatasource = RemoteDatasource()
}

extension RemoteDatasource: RemoteDatasourceProtocol {
    
    func getDetailMenu(recipeId: Int) -> AnyPublisher<MenuDetailResponse, Error> {
        return Future<MenuDetailResponse, Error> { completion in
            if let url = URL(string: EndPoints.Gets.recipeInformation(recipeId: recipeId).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MenuDetailResponse.self) { (response) in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                            
                            
                        case .failure(let err):
                            completion(.failure(err))
                        }
                        
                        
                    }
            }
            
        }.eraseToAnyPublisher()
    }
    
  
    
    func getRandomMenu() -> AnyPublisher<[RandomMenuResponse], Error> {
        return Future<[RandomMenuResponse], Error> { completion in
            if let url = URL(string: EndPoints.Gets.randomMenu.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: Response.self) { (response) in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.result))
                            
                            
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                            
                        }
                        
                        
                    }
            }
            
        }.eraseToAnyPublisher()
    }
    
  
    
    
}

