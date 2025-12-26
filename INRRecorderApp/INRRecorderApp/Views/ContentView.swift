//
//  ContentView.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 20.12.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [DosagePoint]
    @Query var allSettings: [INRRecorderSettings]
    @State private var isPresentingSettingsView = false
    @State var settings : INRRecorderSettings?
    

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.mesasurementDate!, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.mesasurementDate!, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem{
                    Button(action:openSettings) {
                        Label("Konfiguration", systemImage: "wrench")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingSettingsView) {
            NavigationStack {
                SettingsView(settings: $settings)
            }.navigationTitle("Einstellungen")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = DosagePoint(mesasurementDate: .now, drugName: "Test Drug", drugDosage: 1, drugPillCount: 1)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    private func openSettings() {
        if (allSettings.count > 0) {
            settings = allSettings[0]
        } else {
            settings = INRRecorderSettings()
            modelContext.insert(settings!)
        }
        isPresentingSettingsView = true
    }
}

#Preview {
    ContentView()
        .modelContainer(for: DosagePoint.self, inMemory: true)
}
