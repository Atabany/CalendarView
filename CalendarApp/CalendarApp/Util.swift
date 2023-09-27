//
//  Util.swift
//  CalendarApp
//
//  Created by Mohamed Elatabany on 28/09/2023.
//

import Foundation

extension Date {
    var calendar: Calendar {
        var cal = Calendar.current
        cal.firstWeekday = 2 // 2 represents Monday
        return cal
    }

    func isSameDay(as otherDate: Date) -> Bool {
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}

let monthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
}()

let yearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "y"
    return formatter
}()

