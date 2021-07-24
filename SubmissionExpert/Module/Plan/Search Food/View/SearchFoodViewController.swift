//
//  SearchFoodViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import UIKit

class SearchFoodViewController: UIViewController {

    let searchController = UISearchController()
    
    @IBOutlet weak var cvSearchFood: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        cvSearchFood.dataSource = self
        cvSearchFood.delegate = self
        
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
    }

}

extension SearchFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSearchFood.dequeueReusableCell(withReuseIdentifier: "foodplansearchcell", for: indexPath)
        
        return cell
    }
    
    
}
