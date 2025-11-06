//
//  RecallListViewModel.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import Foundation

@MainActor
class RecallListViewModel: ObservableObject {
    @Published private(set) var items: [RecallItem] = []
    
    // Get a reference to our singleton manager.
    private let notificationManager = NotificationManager.shared
    
    // Public method to be called from the View.
    func requestNotificationPermission() {
        notificationManager.requestAuthorization()
    }
    
    func addItem(content: String) {
        guard !content.isEmpty else { return }
        
        let newItem = RecallItem(content: content)
        items.insert(newItem, at: 0)
        
        // --- NEW LOGIC HERE ---
        // 1. Calculate the reminder dates.
        let reminderDates = ForgettingCurve.reminderDates(from: newItem.createdAt)
        // 2. Schedule notifications for these dates.
        notificationManager.scheduleNotifications(for: newItem, on: reminderDates)
    }
    
    func getReminderDates(for item: RecallItem) -> [Date] {
        return ForgettingCurve.reminderDates(from: item.createdAt)
    }
}
