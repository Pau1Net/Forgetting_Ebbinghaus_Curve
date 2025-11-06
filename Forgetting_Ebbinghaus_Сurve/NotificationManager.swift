//
//  NotificationManager.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import Foundation
import UserNotifications

// A dedicated manager for all notification-related tasks.
// Using a final class singleton pattern.
final class NotificationManager {
    
    // A single, shared instance of the manager.
    static let shared = NotificationManager()
    private init() {} // Private initializer to prevent creating other instances.
    
    // Asks the user for permission to send notifications.
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                // For a real app, you'd want to handle this error.
                print("NOTIFICATION ERROR: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(success)")
            }
        }
    }
    
    // Schedules a series of notifications for a given item.
    func scheduleNotifications(for item: RecallItem, on dates: [Date]) {
        for date in dates {
            let content = UNMutableNotificationContent()
            content.title = "Time to recall!"
            content.body = item.content
            content.sound = .default
            
            // Trigger the notification on the specific date and time.
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            // Create a unique identifier for the request.
            // This is crucial for being able to cancel it later.
            let requestIdentifier = "\(item.id)-\(date.timeIntervalSince1970)"
            let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                }
            }
        }
        
        print("Scheduled \(dates.count) notifications for '\(item.content)'")
    }
}
