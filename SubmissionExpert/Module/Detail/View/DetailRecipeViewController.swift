//
//  DetailRecipeViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/05/21.
//

import UIKit
import Combine

class DetailRecipeViewController: UIViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var navigationItemDetail: UINavigationItem!
    var ingridientView: UIView!
    var summaryView: UIView!
    
    var presenter: DetailPresenter?
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
  
    private var detailResponse: DetailResponse?
    
    private var ingridientResponse : [IngridientResponse] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    
        navigationItemDetail.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(save))
        
        ingridientView = IngridientViewController().view
        summaryView = SummaryViewController().view
        
        viewContainer.addSubview(ingridientView)
        viewContainer.addSubview(summaryView)
        
        viewContainer.bringSubviewToFront(ingridientView)
        
        getRecipeDetail(recipeId: 654812)
        
    
    }
    
    private func setup() {
        
        let usecase = Injection().provideHomeUseCase()
        self.presenter = DetailPresenter(useCase: usecase)

    }
    
    
    @objc func save(){
      
    }
    
    private func getRecipeDetail(recipeId: Int){
        loadingState = true
        presenter?.getDetail(recipeId: recipeId).receive(on: RunLoop.main).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                self.loadingState = false
                
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        }, receiveValue: { (result) in
            self.detailResponse = result
            self.navigationItemDetail.title = result.title
            
        }).store(in: &cancellables)
    }
    
    @IBAction func switchAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewContainer.bringSubviewToFront(ingridientView)
            break
        case 1:
            viewContainer.bringSubviewToFront(summaryView)
            break
        default:
            viewContainer.bringSubviewToFront(summaryView)
            break
        }
    }
    

  

}
