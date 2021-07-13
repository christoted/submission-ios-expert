//
//  SearchViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 11/07/21.
//

import UIKit
import Alamofire
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var cvSearch: UICollectionView!
    
    @IBOutlet weak var searhBar: UISearchBar!
    
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
            self.cvSearch.reloadData()
        }.store(in: &cancellables)
    }
    
}




extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultSearch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = cvSearch.dequeueReusableCell(withReuseIdentifier: "cellsearch", for: indexPath) as! SearchViewCell
        
        cell.lblTitle.text = resultSearch[indexPath.row].title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Lebar & tinggil cell
        return CGSize(width: 350, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 15, left: 5, bottom: 0, right: 5)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let title = searchBar.text
        self.getSearchMenu(name: title as! String ?? "")
        
    }
    
}
