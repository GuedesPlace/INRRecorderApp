//
//  DayHeader.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 29.12.2025.
//

import SwiftUI

struct DayHeader: View {
    @Binding var selectedDate:Date;
    var body: some View {
        VStack {
            HStack {
                Button ("",systemImage: "chevron.left", action:{declineOneDay(to: $selectedDate)})
                Spacer()
                Image(systemName: "\(selectedDate.dayNumberAsString).calendar").resizable().frame(width: 150, height: 150)
                Spacer()
                Button ("",systemImage: "chevron.right", action:{addOneDay(to: $selectedDate)})
            }.padding()
            Text("\(selectedDate.monthAsFullStringWithYear)").font(.headline)
        }.padding()
    }
    func addOneDay(to bindingDate: Binding<Date>) {
            if let newDate = Calendar.current.date(byAdding: .day, value: 1, to: bindingDate.wrappedValue) {
                bindingDate.wrappedValue = newDate
            }
        }
    func declineOneDay(to bindingDate: Binding<Date>) {
            if let newDate = Calendar.current.date(byAdding: .day, value: -1, to: bindingDate.wrappedValue) {
                bindingDate.wrappedValue = newDate
            }
        }
}

#Preview {
    @Previewable @State var selectedDate: Date = Date()
    DayHeader(selectedDate: $selectedDate)
}
