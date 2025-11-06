//
//  Forgetting_Ebbinghaus__urveApp.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import SwiftUI

@main
struct Forgetting_Ebbinghaus_urveApp: App {
    
    // --- ADD THIS INITIALIZER ---
    // This is the earliest point in the app's lifecycle.
    init() {
        NotificationManager.shared.setupDelegate()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
