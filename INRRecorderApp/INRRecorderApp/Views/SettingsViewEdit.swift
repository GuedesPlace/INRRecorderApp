//
//  SettingsViewEdit.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 24.12.2025.
//

import SwiftUI
import SwiftData

struct SettingsViewEdit: View {
    let settings: INRRecorderSettings;
    
    @State private var drugName:String
    @State private var drugDose:Int
    @State private var drugSplittingCapability: DrugSplittingPosiblity
    @State private var dayOfMeasurement: WeekDays = .sunday
    
    @State private var lowerBound: Int
    @State private var upperBound: Int

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let step = 1
    let range = 1...200
    init(settings: INRRecorderSettings) {
        self.settings = settings
        self.drugName = settings.drugName ?? ""
        self.drugDose = settings.drugDose ?? 1
        self.drugSplittingCapability = settings.drugSplittingCapability ?? .none
        self.dayOfMeasurement = settings.dayForMeasurement ?? .sunday
        self.lowerBound = settings.inrLowerBoundary ?? 20
        self.upperBound = settings.inrUpperBoundary ?? 30
    }
    var body: some View {
        Form {
            Section(header: Text("Verwendetes Medikament")) {
                TextField("Name das Medikament", text: $drugName)
                Stepper(
                    value: $drugDose,
                    in: range,
                    step: step,
                ) {Text("Pillengrösse: \(drugDose) mg")}
                Picker(selection: $drugSplittingCapability) {
                    Text("Keine").tag(DrugSplittingPosiblity.none)
                        Text("Halbieren").tag(DrugSplittingPosiblity.half)
                        Text("Vierteln").tag(DrugSplittingPosiblity.quater)
                    } label: {
                        Text("Teilbarkeit")
                        Text("Wie kann die Tablette geteilt werden")
                    }
            }
            Section(header: Text("Einstellungen für die Protokollierung")) {
                Picker(selection: $dayOfMeasurement) {
                 ForEach(WeekDays.allCases, id: \.self) { day in
                        Text(day.getWeekDayName()).tag(day)
                    }
                } label: {
                    Text("Tag der Messsung")
                    Text("Wann findet die Messung statt")
                }
                HStack() {
                    VStack(alignment: .center, spacing: 10) {
                        Text("INR Zielbereich: \(lowerBound) – \(upperBound)")
                        HStack {
                            Stepper(value: $lowerBound, in: 0...upperBound, step: 1) {Text("")}
                            Spacer()
                            Stepper(value: $upperBound, in: lowerBound...60, step: 1) {Text("")}
                        }
                    }
                    .padding()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Abbruch") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Aktualisieren") {
                    do {
                        try saveEdits()
                        dismiss()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
    private func saveEdits() throws {
        settings.dayForMeasurement = dayOfMeasurement
        settings.drugDose = drugDose
        settings.drugName = drugName
        settings.drugSplittingCapability = drugSplittingCapability
        settings.inrLowerBoundary = lowerBound
        settings.inrUpperBoundary = upperBound
        settings.updatedAt = .now
        try context.save()
    }
}

#Preview(traits: .blankSettingsSampleData) {
    @Previewable @Query(sort: \INRRecorderSettings.key) var settings: [INRRecorderSettings]
    NavigationStack {
        SettingsViewEdit(settings: settings[0])
    }
}
