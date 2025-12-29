//
//  INRMeasurementPoint.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 24.12.2025.
//

import Foundation
import SwiftData

@Model
class INRMeasurementPoint: Identifiable {
    public var id: UUID?
    var mesasurementDate: Date?
    var lastUpdated: Date?
    var inrValue: Int?
    var plandDrugName: String?
    var planedPillSize: Int?
    var planedPillCountMonday: Int?
    var planedPillCountTuesday: Int?
    var planedPillCountWednesday: Int?
    var planedPillCountThursday: Int?
    var planedPillCountFriday: Int?
    var planedPillCountSaturday: Int?
    var planedPillCountSunday: Int?
    var isoWeek: Int?
    var isoYear: Int?
    
    
    public init(id:UUID = UUID(), mesasurementDate: Date, inrValue: Int) {
        self.id = id
        self.mesasurementDate = mesasurementDate
        self.lastUpdated = Date()
        self.inrValue = inrValue
        self.lastUpdated = Date()
        var iso = mesasurementDate.isoWeek
        self.isoWeek = iso.week
        self.isoYear = iso.year
    }
}
