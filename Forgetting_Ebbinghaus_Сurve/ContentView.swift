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
                    List {
                        ForEach(viewModel.items) { item in
                            // Here we use our new, simple, and modular view.
                            // This resolves the compiler confusion.
                            RecallItemRowView(
                                item: item,
                                reminderDates: viewModel.getReminderDates(for: item)
                            )
                        }
                    }
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

