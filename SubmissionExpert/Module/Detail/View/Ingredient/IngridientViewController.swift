//
//  IngridientViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/05/21.
//

import UIKit
import Combine

class IngridientViewController: UIViewController {

    @IBOutlet weak var tablleView: UITableView!
    
    var presenter: DetailPresenter?
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    static let instance = IngridientViewController()
    
    var ingridientList: [IngridientResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        // Do any additional setup after loading the view.
        registerTableViewCell()
        tablleView.delegate = self
        tablleView.dataSource = self
        
      //  getRecipeDetail(recipeId: 654812)
       
    }
    
    private func registerTableViewCell(){
        tablleView.register(UINib(nibName: "IngridientTableViewCell", bundle: nil), forCellReuseIdentifier: "ingcell")
    }
    
    private func setup(){
        let usecase = Injection().provideHomeUseCase()
        self.presenter = DetailPresenter(useCase: usecase)
    }
    
    private func getRecipeDetail(recipeId: Int) {
        loadingState = true
        presenter?.getDetail(recipeId: recipeId).receive(on: RunLoop.main).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished:
                self.loadingState = false
                
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        }, receiveValue: { (result) in
            self.ingridientList = result.extendedIngredients!
            print("LIST ", self.ingridientList)
            self.tablleView.reloadData()
           
        }).store(in: &cancellables)
    }

}

extension IngridientViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablleView.dequeueReusableCell(withIdentifier: "ingcell") as! IngridientTableViewCell
        
        cell.labelTitle.text = "TEST"
        cell.labelDesc.text = "TEST 2"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    
}
