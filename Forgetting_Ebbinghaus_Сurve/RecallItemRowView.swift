//
//  RecallItemRowView.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import SwiftUI

struct RecallItemRowView: View {
    let item: RecallItem
    let reminderDates: [Date]
    // Теперь мы принимаем конкретную дату для обратного отсчета.
    let nextReminderDate: Date?
    
    // Этот таймер будет срабатывать каждую секунду и обновлять UI.
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemainingString: String = "Loading..."
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) { // Увеличил отступ для красоты
            Text(item.content)
                .font(.headline)
            
            // --- ОТОБРАЖЕНИЕ ТАЙМЕРА ЗДЕСЬ ---
            // Заметный дисплей для обратного отсчета.
            if let nextDate = nextReminderDate {
                Text("Next recall in: \(timeRemainingString)")
                    .font(.subheadline.monospaced()) // Моноширинный шрифт для таймеров
                    .foregroundStyle(.secondary)
            } else {
                 Text("All recalls complete!")
                    .font(.subheadline)
                    .foregroundStyle(.green)
            }
            
            DisclosureGroup("All reminders") { // Изменил заголовок для ясности
                VStack(alignment: .leading) {
                    ForEach(reminderDates, id: \.self) { date in
                        Text(date.formatted(.dateTime.day().month().year().hour().minute().second()))
                            .padding(.top, 2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.caption)
        }
        .padding(.vertical, 8)
        .onAppear(perform: updateRemainingTime) // Устанавливаем начальное значение
        .onReceive(timer) { _ in // Обновляем каждую секунду
            updateRemainingTime()
        }
    }
    
    // Приватная вспомогательная функция для чистоты логики.
    private func updateRemainingTime() {
        guard let date = nextReminderDate else {
            timeRemainingString = "N/A"
            return
        }
        
        let remaining = date.timeIntervalSince(Date())
        self.timeRemainingString = remaining.formattedForCountdown()
    }
}
