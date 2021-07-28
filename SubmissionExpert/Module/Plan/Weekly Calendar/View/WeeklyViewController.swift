//
//  PlanViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 21/07/21.
//

import UIKit

struct TestData {
    var title: String?
    var date: Date?
}

class WeeklyViewController: UIViewController {
    
    @IBOutlet weak var cvDate: UICollectionView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var tvFoodList: UITableView!
    
    var selectedDate = Date()
    //MARK:: It will hold the calender day for example 22 Jul, result 22
    var totalSqures = [Date]()
    
    var sectionFood: [String] = ["Morning", "Afternoon", "Evening"]
    var testDataFood:[[String]] = [["Salad", "Nanas", "Nangka 3"], ["Salad 1", "Nanas 1", "4", "5"], ["Salad 2"]]

    var testDataFood2:[[TestData]] = [[TestData(title: "Teddy", date: CalenderHelper().dateStringToDate(date: "2021/07/26"))], [TestData(title: "Nuchika", date: CalenderHelper().dateStringToDate(date: "2021/07/26"))],
        [TestData(title: "James", date: CalenderHelper().dateStringToDate(date: "2021/07/26"))]
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvDate.dataSource = self
        cvDate.delegate = self
        self.navigationItem.title = "Plan Your Diet"
        
        setCellsView()
        setWeekView()
        
        //MARK:: Register the Table View Cell
        registerTableViewCell()
        
    }
    
    private func registerTableViewCell() {
        tvFoodList.register(UINib(nibName: "FoodPlannerTableViewCell", bundle: nil), forCellReuseIdentifier: "foodplannercell")
        tvFoodList.delegate = self
        tvFoodList.dataSource = self
    }
    
    //MARK:: For Display the data that the content is same Calendar
    private func manageData(){
        
    }
    
    @IBAction func unwindSegueFromAddFoodVC(_ sender: UIStoryboardSegue) {
        //backtoweekly
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
        }
    }
    
    @IBAction func btnNextMonth(_ sender: Any) {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    
    @IBAction func btnPrevMonth(_ sender: Any) {
        selectedDate = CalenderHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionFood[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            let sectionMorning = testDataFood[section].count
            print("Pagi ", sectionMorning)
            return sectionMorning
        case 1 :
            let sectionAfternoon = testDataFood[section].count
            print("Siang ", sectionAfternoon)
            return sectionAfternoon
        case 2 :
            let sectionNight = testDataFood[section].count
            print("Malem ", sectionNight)
            return sectionNight
        default :
            let sectionMorning = testDataFood[section].count
            print(sectionMorning)
            return sectionMorning
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvFoodList.dequeueReusableCell(withIdentifier: "foodplannercell") as! FoodPlannerTableViewCell
        print("TEST BRO", selectedDate)
        return cell
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
        print(CalenderHelper().dateFormatter(date: selectedDate ?? Date()))
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (cvDate.frame.size.width) / 9
        let height = (cvDate.frame.size.height) / 4.5
        
        let flowLayout = cvDate.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        return flowLayout.itemSize
    }
    
    
}
