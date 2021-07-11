//
//  SearchViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 11/07/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var cvSearch: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvSearch.dequeueReusableCell(withReuseIdentifier: "cellsearch", for: indexPath) as? SearchViewCell
    }
    
    
}
