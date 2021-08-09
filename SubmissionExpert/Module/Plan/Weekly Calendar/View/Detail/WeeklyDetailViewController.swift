//
//  WeeklyDetailViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 09/08/21.
//

import UIKit

class WeeklyDetailViewController: UIViewController {

    @IBOutlet weak var cvPlanWeeklyDetail: UICollectionView!
    var titleFood: String = ""
    var foodPlan: PlanModel?
    var listFoodPlanDetail: [MenuModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "\(titleFood)"
        print("Food Plan",foodPlan)
    }
}

extension WeeklyDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvPlanWeeklyDetail.dequeueReusableCell(withReuseIdentifier: "cellsearch", for: indexPath) as! SearchViewCell
        
        return cell
    }
    
    
}

