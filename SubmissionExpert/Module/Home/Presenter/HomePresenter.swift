//
//  HomePresenter.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 22/05/21.
//

import Foundation
import Combine

class HomePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
  
    private let useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    @Published var randomMenu:[RandomMenuResponse] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    func getCategories() {
        loadingState = true
        useCase.getRandomMenu().receive(on: RunLoop.main).sink { (completion) in
            switch completion {
            
            case .finished:
                self.loadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        } receiveValue: { (result) in
            self.randomMenu = result
        }.store(in: &cancellables)

    }
}
