//
//  AddFoodViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import UIKit

class AddFoodViewController: UIViewController {
    
    @IBOutlet weak var addPlanButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cvResultFood: UICollectionView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    var addFoodPresenter: AddFoodPresenter?
    
    var listResultFoodPicked:[MenuModel] = []
    var resultFoodPicker: MenuModel?
    
    var resultBack: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvResultFood.dataSource = self
        cvResultFood.delegate = self
        
        initFoodPresenter()
        registerCVResultFood()
        setUpCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("DID APPER", listResultFoodPicked.count)
    }
    
    private func initFoodPresenter(){
        let useCase = Injection().provideHomeUseCase()
        addFoodPresenter = AddFoodPresenter(useCase: useCase)
    }
    
    private func registerCVResultFood(){
        cvResultFood.register(UINib(nibName: "ChooseFoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "foodplanresult")
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        cvResultFood
            .setCollectionViewLayout(layout, animated: true)
    }
    
    @IBAction func addPlanActionButton(_ sender: Any) {
    }
    
    
    @IBAction func chooseFood(_ sender: Any) {
        performSegue(withIdentifier: "seguetosearchfood", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguetosearchfood" {
            let destSearchFoodNC = segue.destination as! SearchFoodNavigationController
            let destSearchFoodVC = destSearchFoodNC.topViewController as? SearchFoodViewController
            destSearchFoodVC?.searchFoodPresenter = AddFoodRouter().navigateToSearchFoodModule()
        }
    }
    
    @IBAction func unwindSegueFromSearchFood(_ sender: UIStoryboardSegue) {
        if resultFoodPicker != nil {
            listResultFoodPicked.append(resultFoodPicker!)
            self.dateLabel.text = resultFoodPicker?.title
            print(listResultFoodPicked.count)
            cvResultFood.reloadData()
        }
    }
}

extension AddFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("HITUNG", listResultFoodPicked.count)
        return listResultFoodPicked.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = cvResultFood.dequeueReusableCell(withReuseIdentifier: "foodplanresult", for: indexPath) as! ChooseFoodCollectionViewCell
        print("COUNT", listResultFoodPicked.count)
        if (listResultFoodPicked.count > 0) {
            print("COUNT", listResultFoodPicked[0].title)
            cell.chooseFoodLabel.text = listResultFoodPicked[indexPath.row].title
            let imageString = listResultFoodPicked[indexPath.row].image
            DispatchQueue.global(qos: .userInteractive).async {
                let imageURL = URL(string: imageString!)
                let imageData = try? Data(contentsOf: imageURL!)
                DispatchQueue.main.async {
                    if (imageData != nil) {
                        cell.chooseFoodImageView.image = UIImage(data: imageData!)
                    }
                }
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
    
    
}
