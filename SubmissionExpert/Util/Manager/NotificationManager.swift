//
//  NotificationManager.swift
//  SubmissionExpert
//
//  Created by Christopher Teddy  on 13/08/21.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    //MARK:: Request Permission
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert,.badge,.sound]) { granted, _ in
                completion(granted)
            }
    }
 
    //MARK:: Creating Notification
    func scheduleNotification2(planModel: PlanModel) {
        let content = UNMutableNotificationContent()
        content.title = "Perhatian bro"
        content.body = "Gentle reminder for your task!"
        var trigger:UNNotificationTrigger?
        //TODO:: Need to Change the Calendar
        guard let planDate = planModel.date else {
            return
        }
        trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year], from: CalenderHelper().dateStringToDate(date: planDate)), repeats: true)
        print("Calendar \(Calendar.current.dateComponents([.day], from: CalenderHelper().dateStringToDate(date: planDate)))")
        //trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
       // trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.day, .month, .year], from: Date()), repeats: true)
        if let trigger = trigger {
            let request = UNNotificationRequest(identifier: "\(String(describing: planModel.id))", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error",error)
                }
                print("Bisa masuk atas")
            }
            print("Bisa masuk nih")
        }
        
        content.threadIdentifier = "CalendarBasedNotificationThreadId"
    }
    
}
