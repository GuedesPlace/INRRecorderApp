//
//  TodayView.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 29.12.2025.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var context
    
    private var range: (start: Date, end: Date)
    @State var currentDate:Date;
    @State var dayElements: [DayElement]
    @State private var errorMessage: String?

    
    init() {
        let today = Date()
        self.currentDate = today;
        let weekDateRange = today.isoWeekStartEnd
        self.range = weekDateRange
        self.dayElements = []
        
    }
    private var dateRangeForWeek: (start:Date, end:Date) { currentDate.isoWeekStartEnd }
    var body: some View {
            VStack {
                DayHeader(selectedDate: $currentDate)
                Section(header:Text("KW: \(currentDate.isoWeekYearAsString)")) {
                    ScrollView {
                        VStack {
                            ForEach(dayElements, id:\.id) {
                                dayElement in
                                NavigationLink(value:dayElement.id )
                                {
                                    DayElementItemView(dayElement: dayElement, selecteDate: currentDate)
                                }
                            }
                        }
                    }.scrollIndicators(.visible)
                }
            }
            .padding()
            .onChange(of: currentDate) { prevValue, newValue in
                print("Datum geändert → KW/Jahr: \(newValue.isoWeekYearAsString))")
                let prevRange = prevValue.isoWeekStartEnd
                if (newValue < prevRange.start || newValue > prevRange.end  ) {
                    Task { @MainActor in
                        await loadDataForWeek();
                    }
                }
            }
            .task { await loadDataForWeek() }
            .refreshable { await loadDataForWeek() } // Pull-to-refresh
    }
    
    @MainActor
    private func loadDataForWeek() async {
        do {
            print ("Load DataForWeek aufgerufen")
            let points = try fetchSelectedtWeek(context: context, start:range.start, end:range.end)
            dayElements = DayElement.createDayElementsForRestOfWeek(currentDate: currentDate, dosagePoints: points)
            errorMessage = nil
        } catch {
                errorMessage = "Fehler beim Laden: \(error.localizedDescription)"
        }
    }

    func fetchSelectedtWeek(context: ModelContext, start:Date, end:Date) throws -> [DosagePoint] {
        let predicate = #Predicate<DosagePoint> { obj in
            obj.measurementDate.flatMap{ d in d <= end && d >= start } ?? false;
        }
        let descriptor = FetchDescriptor<DosagePoint>(
            predicate: predicate,
            sortBy: [SortDescriptor(\DosagePoint.measurementDate, order: .reverse)]
        )
        return try context.fetch(descriptor)
    }

}

#Preview (traits: .dosageSampleData) {
    NavigationStack {
        TodayView()
    }.navigationTitle("Aktuell")
}
