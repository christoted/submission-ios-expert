//
//  SearchViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 11/07/21.
//

import UIKit
import Alamofire
import Combine
import Lottie

class SearchViewController: UIViewController {
    
    @IBOutlet weak var cvSearch: UICollectionView!
    
    @IBOutlet weak var searhBar: UISearchBar!
    @IBOutlet weak var emptyStateAnimationView: AnimationView!
    
    var presenter: SearchPresenter?
    
    private var resultSearch: [MenuModel] = []
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCell()
        searhBar.delegate = self
        cvSearch.delegate = self
        cvSearch.dataSource = self
        
        checkDataEmpty()
    }
    
    private func initAnimationView(){
    
        emptyStateAnimationView.loopMode = .loop
    
        emptyStateAnimationView.animationSpeed = 0.5
        
        emptyStateAnimationView.play()
    }
    
    private func checkDataEmpty(){
        if resultSearch.isEmpty {
            cvSearch.isHidden = true
            initAnimationView()
        } else {
            cvSearch.isHidden = false
            emptyStateAnimationView.isHidden = true
        }
    }
    
    private func registerCollectionViewCell () {
        cvSearch.register(UINib(nibName: "SearchViewCell", bundle: nil), forCellWithReuseIdentifier: "cellsearch")
    }
    
    private func getSearchMenu(name: String) {
        loadingState = true
        presenter?.getSearchMenu(recipeName: name).receive(on: RunLoop.main).sink { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        } receiveValue: { (result) in
            self.resultSearch = result
            print(self.resultSearch)
            
            if !result.isEmpty {
                self.cvSearch.reloadData()
                self.cvSearch.isHidden = false
                self.emptyStateAnimationView.isHidden = true
            } else {
                self.cvSearch.isHidden = true
                self.initAnimationView()
            }
            
           
        }.store(in: &cancellables)
    }
    
}




extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    enum imageEnum: Error {
        case imageEmpty
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = cvSearch.dequeueReusableCell(withReuseIdentifier: "cellsearch", for: indexPath) as! SearchViewCell
        
        cell.lblTitle.text = resultSearch[indexPath.row].title
        cell.lblId.text = "\(resultSearch[indexPath.row].id ?? 0)" as String
        
        guard let imageURL = resultSearch[indexPath.row].image else {
            return cell
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let url = URL(string: imageURL)
            
            let imageData = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                cell.imageSearch.image = UIImage(data: imageData!)
            }
            
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailFromSearch", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromSearch" {
            let dest = segue.destination as? DetailRecipeViewController
            let row  = (sender as! NSIndexPath).row
            dest?.recipeId = resultSearch[row].id ?? 654812
            dest?.presenter?.searchRouter = presenter?.searchRouter
            dest?.presenter = presenter?.searchRouter?.navigateToDetailModule()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Lebar & tinggil cell
        return CGSize(width: 400, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 15, left: 5, bottom: 0, right: 5)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let title = searchBar.text
        self.getSearchMenu(name: title ?? "" )
        
        if title?.count == 0 {
            cvSearch.isHidden = true
            initAnimationView()
        }
    }
    
}
