//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Mohamed Elatabany on 28/09/2023.
//

import Foundation
import SwiftUI

struct CalendarView: View {
    let calendar = Calendar.current

    let daysOfWeek = Array(Calendar.current.shortWeekdaySymbols[1...]) + [Calendar.current.shortWeekdaySymbols.first!]
    
    @State private var selectedDate: Date = Date()
    @State private var monthOffset: Int = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            // Month and Year Navigation
            HStack {
                Button(action: {
                    withAnimation {
                        monthOffset -= 1
                    }
                }) {
                    Image(systemName: "chevron.left")
                }
                
                Spacer()
                
                Text("\(monthFormatter.string(from: currentMonth)) \(yearFormatter.string(from: currentMonth))")
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        monthOffset += 1
                    }
                }) {
                    Image(systemName: "chevron.right")
                }
            }
            
            Divider()
            
            // Weekdays Header
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Days of the month
            ForEach(0..<6) { weekRow in
                HStack {
                    ForEach(0..<7) { dayColumn in
                        if startingWeekday <= dayColumn + 1 || weekRow > 0, let day = dayOfMonth(for: weekRow, dayColumn) {
                            Button(action: {
                                print("Year: \(year), Month: \(month), Day: \(day)")
                                var components = DateComponents(year: year, month: month, day: day)
                                components.calendar = Calendar.current
                                if let selected = components.date {
                                    selectedDate = selected
                                } else {
                                    print("Unable to construct date")
                                }
                            }) {
                                Text("\(day)")
                                    .frame(width: 40, height: 40)
                                    .background(backgroundColor(for: day))
                                    .foregroundColor(textColor(for: day))
                                    .clipShape(Circle())
                            }
                        } else {
                            Text("")
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    
    func backgroundColor(for day: Int) -> Color {

        var components = DateComponents(year: year, month: month, day: day)
        components.calendar = Calendar.current

        guard let date = components.date else {
            return Color.clear
        }
        
        if calendar.isDateInToday(date) {
            return Color.red
        } else if calendar.isDate(selectedDate, inSameDayAs: date) {
            return Color.blue
        } else {
            return Color.clear
        }
    }
    
    func textColor(for day: Int) -> Color {

        var components = DateComponents(year: year, month: month, day: day)
        components.calendar = Calendar.current

        guard let date = components.date else {
            return Color.black
        }

        
        if calendar.isDateInToday(date) || calendar.isDate(selectedDate, inSameDayAs: date) {
            return Color.white
        } else {
            return Color.black
        }
    }


    
    // Computed Properties
    var currentMonth: Date {
        Calendar.current.date(byAdding: .month, value: monthOffset, to: Date()) ?? Date()
    }

    var month: Int {
        Calendar.current.component(.month, from: currentMonth)
    }

    var year: Int {
        Calendar.current.component(.year, from: currentMonth)
    }

    var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: currentMonth)!.count
    }
    
    var startingWeekday: Int {
        return calendar.component(.weekday, from: currentMonth)
    }

    func dayOfMonth(for weekRow: Int, _ dayColumn: Int) -> Int? {
        let day = (weekRow * 7 + dayColumn + 1) - startingWeekday + 1
        return day >= 1 && day <= daysInMonth ? day : nil
    }
    
    func isDateToday(_ day: Int) -> Bool {
        var components = DateComponents(year: year, month: month, day: day)
        components.calendar = calendar
        if let date = components.date {
            return calendar.isDateInToday(date)
        } else {
            return false
        }
    }
}
