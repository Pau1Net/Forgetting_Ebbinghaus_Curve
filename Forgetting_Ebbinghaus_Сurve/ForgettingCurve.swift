//
//  ForgettingCurve.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import Foundation

// Defines the Ebbinghaus forgetting curve intervals.
// This is a dedicated business logic module.
enum ForgettingCurve {
    static let intervals: [TimeInterval] = [
        5,           // 5 seconds
        25,          // 25 seconds
        120,         // 2 minutes
        600,         // 10 minutes
        3600,        // 1 hour
        18000,       // 5 hours
        86400,       // 1 day
        432000,      // 5 days
        2160000,     // 25 days
        10368000,    // 4 months (approx)
        63072000     // 2 years (approx)
    ]

    // Calculates all reminder dates based on a starting date.
    static func reminderDates(from startDate: Date) -> [Date] {
        return intervals.map { interval in
            startDate.addingTimeInterval(interval)
        }
    }
}
