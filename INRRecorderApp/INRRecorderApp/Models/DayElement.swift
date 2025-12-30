//
//  DayElement.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 29.12.2025.
//

import Foundation

struct DayElement: Identifiable {
    var id: UUID
    var relatedDosagePoint: DosagePoint?
    var date:Date
    
    var canCreateNewDosagePoint: Bool {
        return relatedDosagePoint == nil
    }
    
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("ccc")
        return dateFormatter.string(from: date)
    }
    
    var drugName: String {
        if let relatedDosagePoint = relatedDosagePoint {
            return relatedDosagePoint.drugName ?? "--"
        }
        return ""
    }
    var drugDose: Int {
        if let relatedDosagePoint = relatedDosagePoint {
            return relatedDosagePoint.drugDosage ?? 0
        }
        return 0
    }
    var drugPillCount: Int {
        if let relatedDosagePoint = relatedDosagePoint {
            return relatedDosagePoint.drugPillCount ?? 0
        }
        return 0
    }
    init(id:UUID = UUID(), date:Date, relatedDosagePoint: DosagePoint?) {
        self.id = id
        self.date = date
        self.relatedDosagePoint = relatedDosagePoint
    }
}

extension DayElement {
    static func createDayElementsForRestOfWeek(currentDate:Date, dosagePoints: [DosagePoint]) -> [DayElement] {
        let calendar = Calendar(identifier: .iso8601)
        let range = currentDate.isoWeekStartEnd
        
        let dayCount = calendar.dateComponents([.day], from: range.start, to: range.end).day ?? 0
            
            // Erzeuge die Liste 0...dayCount
        let allDates = (0...dayCount-1).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: range.start)
        }
        
        return allDates.compactMap{date in
            let dosagePoint = dosagePoints.first { $0.measurementDate != nil && calendar.isDate($0.measurementDate!, inSameDayAs: date) }
            return DayElement(date: date, relatedDosagePoint: dosagePoint)
        }
    }
}
