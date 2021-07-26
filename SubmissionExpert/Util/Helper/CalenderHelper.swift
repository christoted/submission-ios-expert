//
//  CalenderHelper.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 21/07/21.
//

import Foundation
import UIKit

class CalenderHelper {
    //MARK:: Example 22 July 2021
    let calender = Calendar.current
    
    //MARK:: Result August
    func plusMonth(date: Date) -> Date {
        return calender.date(byAdding: .month, value: 1, to: date)!
    }
    //MARK:: Result June
    func minusMonth(date: Date) -> Date {
        return calender.date(byAdding: .month, value: -1, to: date)!
    }
    
    //MARK:: Result July
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: date)
    }
    
    //MARK:: Result 2021
    func yearStrig(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    //MARK:: Result total days in one month -> 31
    func daysInMonth(date: Date) -> Int {
        let range = calender.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    //MARK:: Current calendar date -> 22
    func dayOfMonth(date: Date) -> Int {
        let components = calender.dateComponents([.day], from: date)
        return components.day!
    }
    //MARK:: Example July 2021 -> Then The First of Month in Thursday
    func firstOfMonth(date: Date) -> Date {
        let components = calender.dateComponents([.year, .month], from: date)
        return calender.date(from: components)!
    }
    
    //Sunday - 1
    //Monday - 2
    //Tueday - 3
    //Wednesday - 4
    //Thusday - 5
    //Friday - 6
    //Saturday - 7
    //MARK:: This is 22 July -> Thursday so return 4 ( 5 - 1 )
    //MARK:: Weekday units are the numbers 1 through n, where n is the number of days in the week. For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
    //MARK:: Gregorian calendar -> Calendar pada umumnya!!!
    func weekDay(date: Date)-> Int {
        let components = calender.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    
    //MARK::For Weekly Calender View
    func addDays(date: Date, days: Int) -> Date {
        return calender.date(byAdding: .day, value: days, to: date)!
    }
    
    //MARK:: Example Today 23 July
    //Then the result will 18 July (Sunday)
    func sundayForDate(date: Date) -> Date {
        var current = date
        let oneWeekAgo = addDays(date: date, days: -7)
        
        while(current > oneWeekAgo) {
            let currentWeekDay = calender.dateComponents([.weekday], from: current).weekday
            //MARK:: Sunday
            if (currentWeekDay == 1) {
                return current
            }
            current = addDays(date: current, days: -1)
        }
        return current
    }
    
    //MARK:: Formatter
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let someDateTime = formatter.string(from: date)
        return someDateTime
    }
}
