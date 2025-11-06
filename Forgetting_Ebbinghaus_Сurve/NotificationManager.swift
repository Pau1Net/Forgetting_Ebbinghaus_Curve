//
//  NotificationManager.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import Foundation
import UserNotifications

// Manager needs to be an NSObject to be a delegate.
final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationManager()
    
    // Make the initializer private again for a true singleton.
    override private init() {
        super.init()
    }
    
    // --- NEW METHOD ---
    // This will be called from the App's entry point.
    func setupDelegate() {
        UNUserNotificationCenter.current().delegate = self
    }
    
    // This delegate method ensures notifications appear when the app is in the foreground.
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        // .banner is the macOS equivalent of .alert
        completionHandler([.banner, .sound, .badge])
    }
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("NOTIFICATION ERROR: \(error.localizedDescription)")
            } else {
                print("Notification permission granted: \(success)")
            }
        }
    }
    
    func scheduleNotifications(for item: RecallItem, on dates: [Date]) {
        // ... (the rest of this function remains unchanged)
        for date in dates {
            let content = UNMutableNotificationContent()
            content.title = "Time to recall!"
            content.body = item.content
            content.sound = .default
            
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
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
