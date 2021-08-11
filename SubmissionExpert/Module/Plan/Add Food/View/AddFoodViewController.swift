//
//  AddFoodViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 24/07/21.
//

import UIKit
import Combine

class AddFoodViewController: UIViewController {
    
    @IBOutlet weak var addPlanButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cvResultFood: UICollectionView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    var addFoodPresenter: AddFoodPresenter?
    
    var listResultFoodPicked:[MenuModel] = []
    var resultFoodPicker: MenuModel?
    
    var pickerData: [String] = []
    var category: String = ""
    var date: Date?
    
    var id: Int = 0
    
    var planId = "PlanId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelDate()
        registerCVResultFood()
        initFoodPresenter()
        setUpCollectionView()
        initPickerData()
        
    }

    
    private func addFoodToDB(){
        if listResultFoodPicked.count == 0 {
            addAlert(title: "Choose One", message: "You haven't choose any food, Please Choose")
        } else {
            let prefences = UserDefaults.standard
            if ( prefences.object(forKey: planId) != nil ) {
                id = prefences.integer(forKey: planId)
            }
           
            let planModel = PlanModel(dayCategory: category, date: dateLabel.text!, listMenuModel: listResultFoodPicked, id: id)
            addFoodPresenter?.addToPlanDB(planEntity: planModel)
            prefences.setValue(id+1, forKey: planId)
     
            print("id \(id)")
        }
    }
    
    private func setLabelDate(){
        let dateString: String = CalenderHelper().dateFormatter(date: date ?? Date())
        dateLabel.text = dateString
    }
    
    private func initPickerData(){
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        pickerData = ["Morning", "Afternoon", "Evening"]
    }
    
    private func initFoodPresenter(){
        let useCase = Injection().provideHomeUseCase()
        addFoodPresenter = AddFoodPresenter(useCase: useCase)
    }
    
    private func registerCVResultFood(){
        cvResultFood.dataSource = self
        cvResultFood.delegate = self
        cvResultFood.register(UINib(nibName: "ChooseFoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "foodplanresult")
    }
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        cvResultFood
            .setCollectionViewLayout(layout, animated: true)
    }
    
    private func addAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { result in
            print(result)
        }))
        self.present(alert, animated: true)
    }
    
    @IBAction func addPlanActionButton(_ sender: Any) {
        print(category)
        if(category.isEmpty) {
            addAlert(title: "Please Choose the Category", message: "If you don't choose the category it might make us confused :D")
        } else {
            performSegue(withIdentifier: "backtoweekly", sender: self)
            addFoodToDB()
        }
    }
    
    
    @IBAction func chooseFood(_ sender: Any) {
        performSegue(withIdentifier: "seguetosearchfood", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguetosearchfood" {
            let destSearchFoodNC = segue.destination as! SearchFoodNavigationController
            let destSearchFoodVC = destSearchFoodNC.topViewController as? SearchFoodViewController
            destSearchFoodVC?.searchFoodPresenter = AddFoodRouter().navigateToSearchFoodModule()
        } else if segue.identifier == "backtoweekly" {
            let dest = segue.destination as! WeeklyViewController
            dest.dateStringFromAddFood = dateLabel.text
        }
    }
    
    @IBAction func unwindSegueFromSearchFood(_ sender: UIStoryboardSegue) {
        if resultFoodPicker != nil {
            listResultFoodPicked.append(resultFoodPicker!)
            cvResultFood.reloadData()
        }
    }
}
//MARK:: For the UI Picker
extension AddFoodViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    //Title for Row
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
        category = pickerData[row]
    }
    
}
//MARK:: For Collection View
extension AddFoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listResultFoodPicked.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvResultFood.dequeueReusableCell(withReuseIdentifier: "foodplanresult", for: indexPath) as! ChooseFoodCollectionViewCell
        if (listResultFoodPicked.count > 0) {
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
