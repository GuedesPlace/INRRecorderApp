//
//  SettingsSample.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 24.12.2025.
//

import Foundation

extension INRRecorderSettings {
        static let blankSettings: INRRecorderSettings = INRRecorderSettings()
}

extension DosagePoint {
    static var fromTodayBack10: [DosagePoint] {
      
        let calendar = Calendar.current
        let today = Date()

        // Erzeuge eine Liste von 11 Tagen: heute und die 10 vorherigen
        let dates = (-1...8).map { offset in
            calendar.date(byAdding: .day, value: -offset, to: today)!
        }
        return dates.map { date in
            DosagePoint(mesasurementDate: date, drugName:"Marcomar", drugDosage: 6, drugPillCount: 125)
        }
    }
}
extension DayElement {
    
    static let todayDayElement = DayElement(date: Date(), relatedDosagePoint: nil)
    static let yesterdayDayElement = DayElement(date: .yesterday, relatedDosagePoint: DosagePoint(mesasurementDate: .yesterday, drugName: "Marcomar", drugDosage: 625, drugPillCount: 125))
    static let tomorrowDayElement = DayElement(date: .tomorrow, relatedDosagePoint: nil)
}
