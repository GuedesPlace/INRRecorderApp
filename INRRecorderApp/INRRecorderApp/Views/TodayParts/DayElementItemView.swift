//
//  DayElementItemView.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 29.12.2025.
//

import SwiftUI

struct DayElementItemView: View {
    let dayElement: DayElement
    let selecteDate: Date
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }()
    func isCurrentDay () -> Bool {
        selecteDate.isSameDayDate(dateToCheck: dayElement.date)
    }
    var body: some View {
            HStack {
                VStack (alignment: .leading) {
                    Text("\(dayElement.dayName)").font(.headline)
                    Text("\(dayElement.date, formatter: dateFormatter)").font(.caption)
                }
                Spacer()
                VStack {
                    if(dayElement.drugPillCount > 0) {
                        DrugDoseLabelView(pillCount:dayElement.drugPillCount)
                    }
                    Text("\(dayElement.drugName)").font(.caption)
                }
                Spacer()
                if (dayElement.canCreateNewDosagePoint) {
                    Image(systemName:"plus")
                } else {
                    Image(systemName: "pencil")
                }
            }.padding().border(isCurrentDay() ? Color.blue : Color.clear)
    }
}

#Preview {
    var selectedDate = Date()
    List {
        DayElementItemView(dayElement: .yesterdayDayElement, selecteDate: selectedDate)
        DayElementItemView(dayElement: .todayDayElement, selecteDate: selectedDate)
        DayElementItemView(dayElement: .tomorrowDayElement, selecteDate: selectedDate)
    }
}
