//
//  PlanViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 21/07/21.
//

import UIKit

class WeeklyViewController: UIViewController {
    
    @IBOutlet weak var cvDate: UICollectionView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var tvFoodList: UITableView!
    
    var selectedDate = Date()
    //MARK:: It will hold the calender day for example 22 Jul, result 22
    var totalSqures = [Date]()
    
    var sectionFood: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvDate.dataSource = self
        cvDate.delegate = self
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Plan Your Diet"
        
        setCellsView()
        setWeekView()
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
