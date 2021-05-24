//
//  RemoteDatasource.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 20/05/21.
//

import Foundation
import Combine
import Alamofire

protocol RemoteDatasourceProtocol: class {
    func getRandomMenu()->AnyPublisher<[RandomMenuResponse], Error>
}

final class RemoteDatasource: NSObject{
    private override init() { }
    
    static let sharedRemoteDatasourceInstance: RemoteDatasource = RemoteDatasource()
}

extension RemoteDatasource: RemoteDatasourceProtocol {
    
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

