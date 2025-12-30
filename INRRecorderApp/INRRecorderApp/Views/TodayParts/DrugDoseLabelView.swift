//
//  DrugDoseLabelView.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 30.12.2025.
//

import SwiftUI

struct DrugDoseLabelView: View {
    let pillCount:Int
    
    init(pillCount:Int) {
        self.pillCount = pillCount
    }
    
    func fullPills() -> Int {
        self.pillCount / 100
    }
    func partCount() -> Int {
        let remain = pillCount - (fullPills() * 100)
        return remain / 25
    }
    var body: some View {
        HStack {
            Image(systemName: "pill").font(.caption2)
            if (fullPills() > 0) {
                Text("\(fullPills())").font(.caption)
            }
            if (partCount() > 0) {
                Text("\(partCount()) / 4").font(.caption).fontWidth(.compressed)
            }
        }
        
    }
}

#Preview {
    VStack {
        DrugDoseLabelView(pillCount:100)
        DrugDoseLabelView(pillCount:225)
        DrugDoseLabelView(pillCount:450)
        DrugDoseLabelView(pillCount:75)
        
        
    }
    
}
