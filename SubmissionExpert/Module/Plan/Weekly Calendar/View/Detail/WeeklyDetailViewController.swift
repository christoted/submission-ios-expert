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
    var listFoodPlanDetail: [MenuModel] = [MenuModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "\(titleFood)"
        print("Food Plan",foodPlan)
        registerCVSearchFood()
        getData()
    }
    
    private func getData(){
        foodPlan!.listMenuModel!.forEach { menus in
            listFoodPlanDetail.append(menus)
        }
    }
    
    private func registerCVSearchFood() {
        cvPlanWeeklyDetail.register(UINib(nibName: "ChooseFoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "foodplansearchcell")
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 4
        cvPlanWeeklyDetail
            .setCollectionViewLayout(layout, animated: true)
    }
    
}

extension WeeklyDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFoodPlanDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvPlanWeeklyDetail.dequeueReusableCell(withReuseIdentifier: "foodplansearchcell", for: indexPath) as! ChooseFoodCollectionViewCell
        let imageString = listFoodPlanDetail[indexPath.row].image
        
        DispatchQueue.global(qos: .userInteractive).async {
            let imageURL = URL(string: imageString!)
            let imageData = try? Data(contentsOf: imageURL!)
            DispatchQueue.main.async {
                cell.chooseFoodImageView.image = UIImage(data: imageData!)
            }
        }
        
        cell.chooseFoodLabel.text = listFoodPlanDetail[indexPath.row].title!
        
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
}

