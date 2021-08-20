//
//  PlanViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 21/07/21.
//

import UIKit
import Combine

struct TestData {
    var title: String?
    var date: Date?
}

class WeeklyViewController: UIViewController {
    
    let morningKey = "Morning"
    let afternoonKey = "Afternoon"
    let eveningKey = "Evening"
    
    @IBOutlet weak var cvDate: UICollectionView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var tvFoodList: UITableView!
    
    var selectedDate = Date()
    //MARK:: It will hold the calender day for example 22 Jul, result 22
    var totalSqures = [Date]()
    
    var weeklyPresenter: WeeklyPresenter?
    
    private var errorMessage: String = ""
    private var loadingState: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    var sectionFood: [String] = ["Morning", "Afternoon", "Evening"]
    var isDataEmpty: Bool = false
    var isDataAfternoonEmpty: Bool = false
    var isDataEvening: Bool = false
    
    var dataFoodPlan = [[PlanModel]]()
    
    var dateStringFromAddFood: String?
    
    //MARK:: Save With Dictonary ["Morning" : ["","",""]
    
    var foodPlans: [String: [PlanModel]] = ["Morning" : [PlanModel](), "Afternoon" : [PlanModel](), "Evening": [PlanModel]()]
    
    var isCheckmarked: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvDate.dataSource = self
        cvDate.delegate = self
        self.navigationItem.title = "Plan Your Diet"
        
        setCellsView()
        setWeekView()
        
        //MARK:: Register the Table View Cell
        registerTableViewCell()
        
        //MARK:: Get Data
        let dateString = CalenderHelper().dateFormatter(date:Date())
        getData(date: dateString)
        
        print("Date",Date())
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData(date: CalenderHelper().dateFormatter(date: selectedDate ?? Date()))
        tvFoodList.reloadData()
        cvDate.reloadData()
    }

    private func registerTableViewCell() {
        tvFoodList.register(UINib(nibName: "FoodPlannerTableViewCell", bundle: nil), forCellReuseIdentifier: "foodplannercell")
        tvFoodList.delegate = self
        tvFoodList.dataSource = self
        tvFoodList.showsVerticalScrollIndicator = false
    }
    
    //MARK:: For Display the data that the content is same Calendar
    private func manageData(){
        
    }
    
    @IBAction func unwindSegueFromAddFoodVC(_ sender: UIStoryboardSegue) {
        
        tvFoodList.reloadData()
        if !dateStringFromAddFood!.isEmpty {
            getData(date: dateStringFromAddFood!)
            print("Date From Add Food \(dateStringFromAddFood)")
           // tvFoodList.reloadData()
            
            let stringDate = CalenderHelper().dateFormatter(date: selectedDate ?? Date())
            getData(date: stringDate)
            tvFoodList.reloadData()
        }
        
        let stringDate = CalenderHelper().dateFormatter(date: selectedDate ?? Date())
        getData(date: stringDate)
        tvFoodList.reloadData()
    }
    
    @IBAction func btnAddPlan(_ sender: Any) {
        performSegue(withIdentifier: "toaddfoodvc", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toaddfoodvc" {
            guard let dest = segue.destination as? AddFoodViewController else {
                return
            }
            dest.date = selectedDate
            dest.addFoodPresenter = WeeklyRouter().navigateToAddFoodModule()
        } else if segue.identifier == "toweeklyfooddetail" {
            
            let destNavigation = segue.destination as! UINavigationController
            
            let targetController = destNavigation.topViewController as! WeeklyDetailViewController
            
            let section =  (sender as! NSIndexPath).section
            print("section", section)
            switch section {
            case 0:
                let row = (sender as! NSIndexPath).row
                targetController.foodPlan = foodPlans["Morning"]![row]
                print("TEST",foodPlans["Morning"]![row] )
                print(section)
                
            case 1:
                let row = (sender as! NSIndexPath).row
                targetController.foodPlan = foodPlans["Afternoon"]![row]
                print("TEST",foodPlans["Afternoon"]![row] )
                print(section)
            case 2:
                let row = (sender as! NSIndexPath).row
                targetController.foodPlan = foodPlans["Evening"]![row]
                print("TEST",foodPlans["Evening"]![row] )
                print(section)
            default:
                let row = (sender as! NSIndexPath).row
                targetController.foodPlan = foodPlans["Morning"]![row]
            }
        }
    }
    
    @IBAction func btnNextMonth(_ sender: Any) {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
        tvFoodList.reloadData()
    }
    
    
    @IBAction func btnPrevMonth(_ sender: Any) {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
        tvFoodList.reloadData()
    }
    
    func setCellsView()
    {
        let width = (cvDate.frame.size.width - 2) / 8
        let height = (cvDate.frame.size.height - 2) / 8
        
        let flowLayout = cvDate.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func setWeekView() {
        totalSqures.removeAll()
        
        var current = CalenderHelper().sundayForDate(date: selectedDate)
        print(current)
        let nextSunday = CalenderHelper().addDays(date: current, days: 7)
        print(nextSunday)
        
        while (current < nextSunday) {
            totalSqures.append(current)
            current = CalenderHelper().addDays(date: current, days: 1)
        }
        lblMonth.text = CalenderHelper().monthString(date: selectedDate) + " " + CalenderHelper().yearStrig(date: selectedDate)
        
        cvDate.reloadData()
    }
}
//MARK:: Manage the Table View Cell
extension WeeklyViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionFood.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100)) //set these values as necessary
        returnedView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 2, y: 0, width: 200, height: 30))
        
        label.text = self.sectionFood[section]
        label.font = label.font.withSize(22)
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        return sectionFood[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            var count = 0
            
            for (indexData, element) in foodPlans["Morning"]!.enumerated() {
                //  let dateInMorningSection = CalenderHelper().dateFormatter(date: foodPlans["Morning"][indexData].date!)
                let dateInMorningSection = foodPlans["Morning"]![indexData].date!
                let selectedDateString = CalenderHelper().dateFormatter(date: selectedDate )
                
                if (selectedDateString == dateInMorningSection) {
                    count = count + 1
                    isDataEmpty = false
                    print("morning data")
                }
            }
            
            if ( count == 0) {
                count = 1
                isDataEmpty = true
                print("morning empty")
            }
            
            return count
        case 1 :
            var count = 0
            for (indexData, element) in foodPlans["Afternoon"]!.enumerated() {
                // let dateInMorningSection = CalenderHelper().dateFormatter(date: testDataFood2[1][indexData].date ?? Date())
                let dateInMorningSection = foodPlans["Afternoon"]![indexData].date!
                let selectedDateString = CalenderHelper().dateFormatter(date: selectedDate )
                if (selectedDateString == dateInMorningSection) {
                    count = count + 1
                    isDataAfternoonEmpty = false
                    print("afternoon data")
                }
            }
            
            if ( count == 0) {
                count = 1
                isDataAfternoonEmpty = true
                print("afternoon empty")
            }
            
            return count
        case 2 :
            var count = 0
            for (indexData, element) in foodPlans["Evening"]!.enumerated() {
                //  let dateInMorningSection = CalenderHelper().dateFormatter(date: testDataFood2[2][indexData].date ?? Date())
                let dateInMorningSection = foodPlans["Evening"]![indexData].date!
                let selectedDateString = CalenderHelper().dateFormatter(date: selectedDate )
                
                if (selectedDateString == dateInMorningSection) {
                    count = count + 1
                    isDataEvening = false
                }
            }
            
            if count == 0 {
                count = 1
                isDataEvening = true
            }
            
            return count
        default :
            var count = 0
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tvFoodList.dequeueReusableCell(withIdentifier: "foodplannercell") as! FoodPlannerTableViewCell
            
            if (isDataEmpty) {
                cell.foodLabel.text = "No Data"
                cell.foodCalLabel.text = "-"
                cell.buttonCheck.isHidden = true
            } else {
                
                guard let foodPlansSave = foodPlans["Morning"] else {
                    return cell
                }
                foodPlansSave.forEach { planModel in
                    let dateInMorningSection = planModel.date!
                    let selectedDateString = CalenderHelper().dateFormatter(date: selectedDate)
                    if dateInMorningSection == selectedDateString {
                       
                        cell.foodLabel.text = foodPlansSave[indexPath.row].foodListTitle
                        cell.foodCalLabel.text = planModel.date
                        cell.buttonCheck.isHidden = false
                        cell.idPlan = foodPlansSave[indexPath.row].id!
                        cell.isButtonSelected = foodPlansSave[indexPath.row].isChecked
                        cell.delegate = self
                        
                        if foodPlansSave[indexPath.row].isChecked! == true {
//                            cell.buttonCheck.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
                            cell.buttonCheck.isSelected = true
                        } else {
                            cell.buttonCheck.isSelected = false
                        }
                    }
                }
            }
            
            return cell
        case 1 :
            let cell = tvFoodList.dequeueReusableCell(withIdentifier: "foodplannercell") as! FoodPlannerTableViewCell
            if (isDataAfternoonEmpty) {
                cell.foodLabel.text = "No Data"
                cell.foodCalLabel.text = "-"
                cell.buttonCheck.isHidden = true
            } else {
                guard let foodPlansSave = foodPlans[afternoonKey] else {
                    return cell
                }
                foodPlansSave.forEach { planModel in
                    let dateInMorningSection = planModel.date!
                    let selectedDateString = CalenderHelper().dateFormatter(date: selectedDate)
                    if dateInMorningSection == selectedDateString {
                       
                        cell.foodLabel.text = foodPlansSave[indexPath.row].foodListTitle
                        cell.foodCalLabel.text = planModel.date
                        cell.buttonCheck.isHidden = false
                        cell.idPlan = foodPlansSave[indexPath.row].id!
                        cell.isButtonSelected = foodPlansSave[indexPath.row].isChecked
                        cell.delegate = self
                    }
                }
            }
            
            return cell
            
        case 2 :
            let cell = tvFoodList.dequeueReusableCell(withIdentifier: "foodplannercell") as! FoodPlannerTableViewCell
            if isDataEvening {
                cell.foodLabel.text = "No Data"
                cell.foodCalLabel.text = "-"
                cell.buttonCheck.isHidden = true
            } else {
                guard let foodPlansSave = foodPlans[eveningKey] else {
                    return cell
                }
                foodPlansSave.forEach { planModel in
                    guard let dateSave = planModel.date else {
                        return
                    }
                    let dateInMorningSection = dateSave
                    let selectedDateString = CalenderHelper().dateFormatter(date: selectedDate)
                    if dateInMorningSection == selectedDateString {
                        cell.foodLabel.text = foodPlansSave[indexPath.row].foodListTitle
                        cell.foodCalLabel.text = planModel.date
                        cell.buttonCheck.isHidden = false
                        cell.idPlan = foodPlansSave[indexPath.row].id!
                        cell.delegate = self
                    }
                }
            }
            return cell
        default:
            let cell = tvFoodList.dequeueReusableCell(withIdentifier: "foodplannercell") as! FoodPlannerTableViewCell
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if isDataEmpty == true {
                print("Empty")
            } else {
                performSegue(withIdentifier: "toweeklyfooddetail", sender: indexPath)
            }
        case 1:
            if isDataAfternoonEmpty  == true {
                print("Empty")
            } else {
                performSegue(withIdentifier: "toweeklyfooddetail", sender: indexPath)
            }
        case 2:
            if isDataEvening  == true {
                print("Empty")
            } else {
                performSegue(withIdentifier: "toweeklyfooddetail", sender: indexPath)
            }
        default:
            if isDataEvening  == true {
                print("Empty")
            } else {
                performSegue(withIdentifier: "toweeklyfooddetail", sender: indexPath)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            if !isDataEmpty {
                return true
            }
        case 1:
            if !isDataAfternoonEmpty {
                return true
            }
        case 2:
            if !isDataEvening {
                return true
            }
        default:
            return false
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if ( editingStyle == .delete) {
            //Check First, isCheck ? can delete : alert woy are you sure because u don't check the finish
        
        }
    }
}

//MARK::Manage the Calendar
extension WeeklyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSqures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvDate.dequeueReusableCell(withReuseIdentifier: "celldate", for: indexPath) as! CalenderCollectionViewCell
        
        let date = totalSqures[indexPath.row]
        cell.lblDay.text = String(CalenderHelper().dayOfMonth(date: date))
        
        if(date == selectedDate)
        {
            cell.backgroundColor = UIColor.systemGreen
            cell.layer.cornerRadius = 10
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSqures[indexPath.item]
        let dateString = CalenderHelper().dateFormatter(date: selectedDate ?? Date())
        print("TEST",dateString)
        //   removeAllDataInArray()
        getData(date: dateString)
        collectionView.reloadData()
        tvFoodList.reloadData()
        
    }
    
    private func removeAllDataInArray(){
        foodPlans["Morning"]?.removeAll()
        foodPlans["Afternoon"]?.removeAll()
        foodPlans["Evening"]?.removeAll()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (cvDate.frame.size.width) / 9
        let height = (cvDate.frame.size.height) / 4.5
        
        let flowLayout = cvDate.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        return flowLayout.itemSize
    }
}

extension WeeklyViewController {
    private func getData(date: String) {
        weeklyPresenter?.getFoodPlanByDate(date: date).receive(on: RunLoop.main).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                self.loadingState = false
            case .failure(_):
                self.errorMessage = String(describing: completion)
            }
        }, receiveValue: { [self] (result) in
            removeAllDataInArray()
            result.forEach { planModel in
                if planModel.dayCategory! == "Morning" {
                    print("Morning")
                    print("Plan Model Morning \(planModel)")
                    print("Checked \(planModel.isChecked)")
                    foodPlans["Morning"]?.append(planModel)
                   
             
                } else if planModel.dayCategory! == "Afternoon" {
                    foodPlans["Afternoon"]?.append(planModel)
                    print("Plan Model Afternoon \(planModel.dayCategory)")
                    print("Plan Model Afternoon \(planModel)")
                  
                   
                } else if planModel.dayCategory! == "Evening" {
                    foodPlans["Evening"]?.append(planModel)
                    print("Plan Model Evening\(planModel.dayCategory)")
                    print("Plan Model Evening \(planModel)")
                 
                }
                tvFoodList.reloadData()
            }
        }).store(in: &cancellables)
    }
}

extension WeeklyViewController: ButtonCheckmarkProtocol {
    func onButtonTapped(isCheckmarked: Bool, idPlan: Int) {
        print("id plan button Tapped \(idPlan) \(isCheckmarked)")
        //MARK:: Update bookmarked
        
            weeklyPresenter?.updateCheckmarked(idPlan: idPlan, isCheckmarked: isCheckmarked)
        
        
    }
}
