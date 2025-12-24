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
    
    init()
    {
        drugSplittingCapability = DrugSplittingPosiblity.none
        dayForMeasurement = .sunday
    }
}
