//
//  RecallItemRowView.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import SwiftUI

// A dedicated, modular view that knows how to display a single RecallItem.
struct RecallItemRowView: View {
    let item: RecallItem
    let reminderDates: [Date]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(item.content)
                .font(.headline)
            
            // --- FIX IS HERE ---
            // Changed date: .shortened to date: .abbreviated
            Text("Created: \(item.createdAt.formatted(date: .abbreviated, time: .shortened))")
                .font(.caption)
                .foregroundStyle(.secondary)

            DisclosureGroup("Next reminders") {
                VStack(alignment: .leading) {
                    ForEach(reminderDates, id: \.self) { date in
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .padding(.top, 2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.caption)
        }
        .padding(.vertical, 5)
    }
}
