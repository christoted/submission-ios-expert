//
//  DetailRecipeViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/05/21.
//

import UIKit
import Combine

class DetailRecipeViewController: UIViewController {
   
    @IBOutlet weak var navigationItemDetail: UINavigationItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableViewDetail: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var ingridientView: UIView!
    var summaryView: UIView!
    
    var presenter: DetailPresenter?
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
  
    private var detailResponse: MenuDetailResponse?
    
    private var ingridientResponse : [IngridientResponse] = []
    
    private var detailModel: MenuModel?
    private var ingridientModel: [IngridientModel] = []
    
    @IBOutlet weak var viewContainer: UIView!
    
    let ingdridient = ["Salad", "Banana"]
    let recipe = ["Chili", "Sour"]
    
    var recipeId: Int?
    
    var isBookmarked: Bool = false
    
    var recipeIdNew: Int?
    
    
    lazy var rowToDisplay = ingdridient
    
    lazy var rowToDisplay2 = ingridientModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        registerTableViewCell()

        navigationItemDetail.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(save))

        tableViewDetail.delegate = self
        tableViewDetail.dataSource = self

        summaryView = SummaryViewController(recipeID: recipeId!, presenter: presenter!).view

        viewContainer.addSubview(summaryView)
        viewContainer.bringSubviewToFront(summaryView)

        indicatorView.startAnimating()

        getRecipeDetailOffline(recipeId: recipeId!)
    }
    

    
    
    @objc func save(){
        isBookmarked = !isBookmarked
        
        print("ATAS", isBookmarked)
        
        guard let recipeIdSave = recipeId else {return }
        
        self.presenter?.updateToBookmarkedMenu(recipeId: recipeIdSave, isBookmarked: isBookmarked)
        
        isBookmarkedState(isBookmarked: isBookmarked)
    }
    
    private func isBookmarkedState(isBookmarked: Bool){
        if (isBookmarked) {
            navigationItemDetail.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart.fill"), style: .plain, target: self, action: #selector(save))
        } else {
            navigationItemDetail.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: .plain, target: self, action: #selector(save))
        }
    }
    
    private func registerTableViewCell(){
        tableViewDetail.register(UINib(nibName: "IngridientTableViewCell", bundle: nil), forCellReuseIdentifier: "ingcell")
    }
    
    /*
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
            self.ingridientResponse = result.extendedIngredients!
            
            
            self.tableViewDetail.reloadData()
        }).store(in: &cancellables)
    }
 */
    
    
    private func getRecipeDetailOffline(recipeId: Int) {
        loadingState = true
        presenter?.getDetailOffline(recipeId: recipeId).receive(on: RunLoop.main).sink(receiveCompletion: { (completion) in
            switch completion {
            case .finished :
                self.loadingState = false
                print("LESAI")
                
            case .failure(_):
                self.errorMessage = String(describing: completion)
                print("FAIL")
            }
        }, receiveValue: { (result) in
            
            print("RESULT ",result)
            
            self.detailModel = result
            self.navigationItemDetail.title = result.title
            self.ingridientModel = result.extendedIngridients!
            self.tableViewDetail.reloadData()
            
            
            let bookmarkedState = result.isBookmarked
            print(bookmarkedState)
            self.isBookmarkedState(isBookmarked: bookmarkedState!)
            
            self.indicatorView.stopAnimating()
            self.indicatorView.hidesWhenStopped = true
            
        }).store(in: &cancellables)
    }
    
    @IBAction func segmentedClicked(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex {
        case 0:
            viewContainer.willRemoveSubview(tableViewDetail)
            viewContainer.addSubview(summaryView)
            viewContainer.bringSubviewToFront(summaryView)
            break
        case 1:
            rowToDisplay2 = ingridientModel
            viewContainer.willRemoveSubview(summaryView)
            viewContainer.addSubview(tableViewDetail)
            viewContainer.bringSubviewToFront(tableViewDetail)
            break
            
        default:
            rowToDisplay2 = ingridientModel
            viewContainer.addSubview(tableViewDetail)
            viewContainer.bringSubviewToFront(tableViewDetail)
            break
            
        }
        
        tableViewDetail.reloadData()
    }
    
}

extension DetailRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewDetail.dequeueReusableCell(withIdentifier: "ingcell") as! IngridientTableViewCell
        
        cell.labelTitle.text = rowToDisplay2[indexPath.row].name
        cell.labelDesc.text = rowToDisplay2[indexPath.row].original
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
