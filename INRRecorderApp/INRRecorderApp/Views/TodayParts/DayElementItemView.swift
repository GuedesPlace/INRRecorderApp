//
//  DayElementItemView.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 29.12.2025.
//

import SwiftUI

struct DayElementItemView: View {
    let dayElement: DayElement
    var body: some View {
        HStack {
            Text("\(dayElement.dayName)")
            Spacer()
            Text("\(dayElement.drugName)")
            Spacer()
            if (dayElement.canCreateNewDosagePoint) {
                Button("", systemImage:"plus", action: {})
            } else {
                Button("", systemImage: "pencil", action: {})
            }
        }.padding()
    }
}

#Preview {
    List {
        DayElementItemView(dayElement: .yesterdayDayElement)
        DayElementItemView(dayElement: .todayDayElement)
        DayElementItemView(dayElement: .tomorrowDayElement)
    }
}
