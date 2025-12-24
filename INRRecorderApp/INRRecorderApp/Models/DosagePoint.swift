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
    var mesasurementDate: Date?
    var lastUpdated: Date?
    var drugName: String?
    var drugDoasge: Int?
    var drugPillCount: Int?
    
    init(id: UUID = UUID(), mesasurementDate: Date, drugName:String, drugDosage: Int, drugPillCount: Int) {
        self.id = id
        self.mesasurementDate = mesasurementDate
        self.lastUpdated = Date()
        self.drugName = drugName
        self.drugDoasge = drugDosage
        self.drugPillCount = drugPillCount
    }
}
