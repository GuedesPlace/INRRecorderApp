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
        NavigationSplitView {
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
            .navigationTitle("Messungen")
            .toolbar {
                ToolbarItem{
                    Button(action:openSettings) {
                        Label("Konfiguration", systemImage: "wrench")
                    }
                }
            }
            .sheet(isPresented: $isPresentingSettingsView) {
                        NavigationStack {
                            SettingsView(settings: $settings)
                        }.navigationTitle("Einstellungen")
                    }
        }
        detail: {
            Text("Detail View")
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
