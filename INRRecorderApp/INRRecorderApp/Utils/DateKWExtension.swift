//
//  DateKWExtension.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 29.12.2025.
//


import Foundation

public extension Date {
    /// ISO‑8601 Kalenderwoche und ISO‑Jahr (Montag als Wochenbeginn)
    var isoWeek: (week: Int, year: Int) {
        var cal = Calendar(identifier: .iso8601)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!  // vermeidet lokale TZ-Drifts nahe Mitternacht
        return (
            cal.component(.weekOfYear, from: self),
            cal.component(.yearForWeekOfYear, from: self)
        )
    }
    
    /// Locale-/Region‑abhängige KW und Jahr
    func week(localeIdentifier: String? = nil, timeZone: TimeZone? = nil) -> (week: Int, year: Int) {
        var cal = Calendar.current
        if let id = localeIdentifier { cal.locale = Locale(identifier: id) }
        if let tz = timeZone { cal.timeZone = tz }
        return (
            cal.component(.weekOfYear, from: self),
            cal.component(.yearForWeekOfYear, from: self)
        )
    }
    var isoWeekYearAsString: String {
        let iso = self.isoWeek
        return String(format: "%02d/%04d", iso.week, iso.year)
        
    }
    var isoWeekStartEnd: (start:Date, end:Date){
        var cal = Calendar(identifier: .iso8601)
        cal.timeZone = TimeZone(secondsFromGMT: 0)! // verhindert Off-by-one bei TZ-Wechseln
        let interval = cal.dateInterval(of: .weekOfYear, for: self)!
        return (interval.start, interval.end)
    }
    var dayNumberAsString: String {
        let myCalendar = Calendar(identifier: .gregorian)
        let dayNumber = myCalendar.dateComponents([.day], from: self)
        return String(dayNumber.day!)
    }
    var monthAsFullStringWithYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return dateFormatter.string(from: self)
    }
    
    func isSameDayDate(dateToCheck:Date) -> Bool {
        let calendar = Calendar(identifier: .iso8601)
        return calendar.isDate(dateToCheck, inSameDayAs: self)
    }
    
    static var yesterday: Date {
            Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        }

    static var tomorrow: Date {
            Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        }

}

