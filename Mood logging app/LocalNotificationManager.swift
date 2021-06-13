//
//  LocalNotificationManager.swift
//  Mood logging app
//
//  Created by Damian Mikołajczak on 13/06/2021.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotificationManager {
    
    func AddLocalNotification(startDate: Date, endDate: Date) {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {granted, error in})
        
        let content = UNMutableNotificationContent()
        content.title = "Time to log your mood"
        content.body = "Please go into the app and log your mood"
        content.sound = .default
        
        
        let notificationInterval = endDate.timeIntervalSince(startDate) / 5
        
        for k in 1...5 {
            
            let triggerDate = startDate.addingTimeInterval(Double(k)*notificationInterval)
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: triggerDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "\(k) notification", content: content, trigger: trigger)
         
            center.add(request, withCompletionHandler: nil)
        }
    }
    
    func RemovePendingNotification(notificationNumber: Int) {
        
        let center = UNUserNotificationCenter.current()
        
        center.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                if (request.identifier == "\(notificationNumber) notification") {
                    center.removePendingNotificationRequests(withIdentifiers: ["\(notificationNumber) notification"] )
                }
            }
        })
        
    }
    
    func RemoveAllPendingNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
}
