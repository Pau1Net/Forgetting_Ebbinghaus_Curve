//
//  ContentView.swift
//  Forgetting_Ebbinghaus_Сurve
//
//  Created by mac on 05.11.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecallListViewModel()
    @State private var newItemContent: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.items.isEmpty {
                    VStack {
                        Spacer()
                        Text("No items yet.")
                            .font(.title)
                        Text("Add something you want to remember!")
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                } else {
                    // Мы используем List, т.к. он предоставляет встроенную поддержку удаления.
                    List {
                        ForEach(viewModel.items) { item in
                            RecallItemRowView(
                                item: item,
                                reminderDates: viewModel.getReminderDates(for: item),
                                nextReminderDate: viewModel.getNextReminderDate(for: item)
                            )
                            // Модификатор для контекстного меню на macOS (правый клик)
                            .contextMenu {
                                Button("Delete", role: .destructive) {
                                    // Находим индекс элемента и вызываем удаление.
                                    if let index = viewModel.items.firstIndex(where: { $0.id == item.id }) {
                                        viewModel.delete(at: IndexSet(integer: index))
                                    }
                                }
                            }
                        }
                        // Модификатор для жеста "свайп-для-удаления" на iOS.
                        .onDelete(perform: viewModel.delete)
                    }
                    // Используем стиль .plain для консистентного вида на всех платформах.
                    .listStyle(.plain)
                }
                
                HStack {
                    TextField("What do you want to remember?", text: $newItemContent)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: addItem) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .disabled(newItemContent.isEmpty)
                }
                .padding()
            }
            .navigationTitle("Recall List")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        viewModel.logAllPendingNotifications()
                    } label: {
                        Label("Show Log", systemImage: "list.bullet.rectangle.portrait")
                    }
                    
                    Button {
                        viewModel.cancelAllPendingNotifications()
                    } label: {
                        Label("Cancel All", systemImage: "trash.circle.fill")
                    }
                }
            }
        }
        .onAppear(perform: viewModel.requestNotificationPermission)
    }
    
    private func addItem() {
        viewModel.addItem(content: newItemContent)
        newItemContent = ""
    }
}

#Preview {
    ContentView()
}
