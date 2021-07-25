//
//  SearchFoodViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import UIKit
import Combine

class SearchFoodViewController: UIViewController {
    
    let searchController = UISearchController()
    
    var searchFoodPresenter: SearchFoodPresenter?
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    var listSearchMenu:[MenuModel] = []
    
    @IBOutlet weak var cvSearchFood: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvSearchFood.dataSource = self
        cvSearchFood.delegate = self
        
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        
        registerCVSearchFood()
        getInitFood()
    }
    
    private func registerCVSearchFood() {
        cvSearchFood.register(UINib(nibName: "ChooseFoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "foodplansearchcell")
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 4
        cvSearchFood
            .setCollectionViewLayout(layout, animated: true)
    }
    
    //MARK::Bad Practice
    private func initPresenter(){
        let useCase = Injection().provideHomeUseCase()
        searchFoodPresenter = SearchFoodPresenter(useCase: useCase)
    }
    
    private func getInitFood(){
        searchFoodPresenter?.getInitFood().receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .finished :
                self.loadingState = true
            case .failure(_) :
                self.errorMessage = "Error"
            }
        }, receiveValue: { result in
            self.listSearchMenu = result
            self.cvSearchFood.reloadData()
            print(result)
        }).store(in: &cancellables)
    }
}



extension SearchFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSearchMenu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSearchFood.dequeueReusableCell(withReuseIdentifier: "foodplansearchcell", for: indexPath) as! ChooseFoodCollectionViewCell
        let imageString = listSearchMenu[indexPath.row].image!
        DispatchQueue.global(qos: .userInteractive).async {
            let imageURL = URL(string: imageString)
            let imageData = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                cell.chooseFoodImageView.image = UIImage(data: imageData!)
            }
        }
        
        cell.chooseFoodLabel.text = listSearchMenu[indexPath.row].title!
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "unwindtoaddfood", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindtoaddfood" {
            let row = (sender as! NSIndexPath).row
            let destUnwind = segue.destination as! AddFoodViewController
            destUnwind.resultBack = "DARI SEARCH OYY"
            destUnwind.resultFoodPicker = listSearchMenu[row]
        }
    }
    
}
