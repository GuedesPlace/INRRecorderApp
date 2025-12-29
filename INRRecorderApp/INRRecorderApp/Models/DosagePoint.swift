//
//  DosagePoint.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 24.12.2025.
//

import Foundation
import SwiftData

@Model
class DosagePoint: Identifiable {
    var id: UUID?
    var measurementDate: Date?
    var lastUpdated: Date?
    var drugName: String?
    var drugDosage: Int?
    var drugPillCount: Int?
    
    init(id: UUID = UUID(), mesasurementDate: Date, drugName:String, drugDosage: Int, drugPillCount: Int) {
        self.id = id
        self.measurementDate = mesasurementDate
        self.lastUpdated = Date()
        self.drugName = drugName
        self.drugDosage = drugDosage
        self.drugPillCount = drugPillCount
    }
}

extension DosagePoint {
     func isInRange(start:Date, end:Date) -> Bool {
        if let d = self.measurementDate {
            return d >= start && d < end
        }
        return false;
    }
}
