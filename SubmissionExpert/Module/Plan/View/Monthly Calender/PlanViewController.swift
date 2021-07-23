//
//  PlanViewController.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 21/07/21.
//

import UIKit

class PlanViewController: UIViewController {
    
    @IBOutlet weak var cvDate: UICollectionView!
    @IBOutlet weak var lblMonth: UILabel!
    
    
    var selectedDate = Date()
    //MARK:: It will hold the calender day for example 22 Jul, result 22
    var totalSqures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvDate.dataSource = self
        cvDate.delegate = self
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Plan Your Diet"
        
        setCellsView()
        setMonthView()
        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd HH:mm"
//        let someDateTime = formatter.date(from: "2021/7/24 22:31")
        
    }
    
    @IBAction func btnNextMonth(_ sender: Any) {
        selectedDate = CalenderHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func btnPrevMonth(_ sender: Any) {
        selectedDate = CalenderHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    func setCellsView()
    {
        let width = (cvDate.frame.size.width - 2) / 8
        let height = (cvDate.frame.size.height - 2) / 8
        
        let flowLayout = cvDate.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func setMonthView() {
        totalSqures.removeAll()
        
        let totalDaysInMonth = CalenderHelper().daysInMonth(date: selectedDate)
        let firstOfMonth = CalenderHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalenderHelper().weekDay(date: firstOfMonth)
    
        var count: Int = 1
        
        while ( count <= 42) {
            if (count <= startingSpaces || count - startingSpaces > totalDaysInMonth) {
                totalSqures.append("")
            } else {
                totalSqures.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        lblMonth.text = CalenderHelper().monthString(date: selectedDate) + " " + CalenderHelper().yearStrig(date: selectedDate)
        
        cvDate.reloadData()
    }
    
    
}

extension PlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSqures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvDate.dequeueReusableCell(withReuseIdentifier: "celldate", for: indexPath) as! CalenderCollectionViewCell
        
        cell.lblDay.text = totalSqures[indexPath.row]
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (cvDate.frame.size.width ) / 9
        let height = (cvDate.frame.size.height ) / 9
        
        let flowLayout = cvDate.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        return flowLayout.itemSize
    }
    
  
    
    
}
