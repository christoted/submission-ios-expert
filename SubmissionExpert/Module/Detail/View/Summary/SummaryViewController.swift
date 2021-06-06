//
//  SummaryViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/05/21.
//

import UIKit
import Combine

class SummaryViewController: UIViewController {
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    var presenter: DetailPresenter?
    
    private var detailResponse: MenuDetailResponse?
    
    private var detailModel: MenuModel?
    
    var recipeId: Int?
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var labelSummary: UITextView!
    
    private var imageURL: String?
    
    init(recipeID: Int) {
          self.recipeId = recipeID
          super.init(nibName: nil, bundle: nil)
      }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setup()
        setupImage()
      //  getRecipeDetail(recipeId: recipeId!)
        getRecipeDetailOffline(recipeId: recipeId!)
    
        // Do any additional setup after loading the view.
    }
    
    private func setupImage(){
        imageDetail.layer.borderWidth = 1.0
        imageDetail.layer.masksToBounds = false
        imageDetail.layer.borderColor = UIColor.white.cgColor
        imageDetail.layer.cornerRadius = CGFloat(20)
        imageDetail.clipsToBounds = true
        
       
    }
    
    private func setup() {
        
        let usecase = Injection().provideHomeUseCase()
        self.presenter = DetailPresenter(useCase: usecase)

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
            self.labelSummary.text = result.summary
            self.imageURL = result.image
            
            guard let imageUrl = self.imageURL else {
                return
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                let url = URL(string: imageUrl)
                let imageData = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    self.imageDetail.image = UIImage(data: imageData!)
                }
            }
            
          
        }).store(in: &cancellables)
    }

    private func getRecipeDetailOffline(recipeId: Int) {
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
            self.labelSummary.text = result.summary
            self.imageURL = result.image
            
            guard let imageUrl = self.imageURL else {
                return
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                let url = URL(string: imageUrl)
                let imageData = try? Data(contentsOf: url!)
                
                DispatchQueue.main.async {
                    self.imageDetail.image = UIImage(data: imageData!)
                }
            }
            
          
        }).store(in: &cancellables)
    }
 

}
