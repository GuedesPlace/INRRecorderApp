//
//  INRRecorderSettings.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 23.12.2025.
//

import Foundation
import SwiftData

enum DrugSplittingPosiblity:String, Codable {
    case none
    case half
    case quater
}
enum WeekDays:String, Codable {
    case monday, tusday, wednesday, thursday, friday, saturday, sunday
    func getWeekDayName() -> String {
        switch self {
        case .monday: return "Montag"
        case .tusday: return "Dienstag"
        case .wednesday: return "Mittwoch"
        case .thursday: return "Donnerstag"
        case .friday: return "Freitag"
        case .saturday: return "Samstag"
        case .sunday: return "Sonntag"
        }
    }
}
@Model
final class INRRecorderSettings{
    var key: String = "default"
    var drugName: String? = nil
    var drugDose: Int? = nil
    var drugSplittingCapability: DrugSplittingPosiblity?
    var dayForMeasurement: WeekDays?
    var inrLowerBoundary: Int? = nil
    var inrUpperBoundary: Int? = nil
    var updatedAt: Date? = nil
    
    init()
    {
        drugSplittingCapability = DrugSplittingPosiblity.none
        dayForMeasurement = .sunday
        updatedAt = .now
    }
}
