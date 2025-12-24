//
//  SettingsView.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 24.12.2025.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    let settings:INRRecorderSettings
    @State private var isPresentingEditView = false
    
    func drugDoseAsText() -> String {
        if let dose = settings.drugDose {
            return "\(dose) mg"
        }
            return "?? mg"
    }
    func drugSeparation() -> String {
        if let separation = settings.drugSplittingCapability {
            switch separation {
            case .none: return "Keine"
            case .half: return "Halbieren"
            case .quater : return "Vierteln"
            }
        }
        return "Nicht definiert";
    }
    func getINRRangeLower() -> String {
        if let inrRange = settings.inrLowerBoundary {
            return "\(inrRange)"
        }
        return "??";
    }
    func getINRRangeUpper() -> String {
        if let inrRange = settings.inrUpperBoundary {
            return "\(inrRange)"
        }
        return "??";
    }
    var body: some View {
        List {
            Section(header: Text("Verwendetes Medikament")) {
                HStack{
                    Label("Medikament", systemImage: "pills")
                    Spacer()
                    Text("\(settings.drugName ?? "(keine Angabe)")")
                }
                HStack{
                    Label("Dosis pro Pille", systemImage: "scalemass")
                    Spacer()
                    Text("\(drugDoseAsText())")
                }
                HStack{
                    Label("Teilbarkeit", systemImage: "squareshape.split.2x2")
                    Spacer()
                    Text("\(drugSeparation())")
                }
            }
            Section(header: Text("Einstellungen für die Protokollierung")) {
                HStack{
                    Label("Tag der Messung", systemImage: "ellipsis.calendar")
                    Spacer()
                    Text("\(settings.dayForMeasurement?.getWeekDayName() ?? "(keine Angabe)")")
                }
                HStack{
                    Label("Zeilbereich für den INR", systemImage: "waveform.path.ecg")
                    Spacer()
                    Text("\(getINRRangeLower()) - \(getINRRangeUpper())")
                }
            }
        }.navigationTitle("Einstellungen")
            .toolbar {
                Button("Bearbeiten") {
                    isPresentingEditView = true
                }
            }
    }
}

#Preview(traits: .blankSettingsSampleData) {
    @Previewable @Query(sort: \INRRecorderSettings.key) var settings: [INRRecorderSettings]
    
    NavigationStack {
        if (settings.count > 0) {
            SettingsView(settings: settings[0])}
        else {
            Text("Loading...")
        }
    }
}
