//
//  CareKitSupport.swift
//  Bikemate
//
//


import Foundation
import CareKitUI

// MARK: - Chart Date UI

func createChartWeeklyDateRangeLabel(lastDate: Date = Date()) -> String {
    let calendar: Calendar = .current
    print("calendar: \(calendar)")
    
    let endOfWeekDate = lastDate
    let startOfWeekDate = getLastWeekStartDate(from: endOfWeekDate)
    
    let monthDayDateFormatter = DateFormatter()
    monthDayDateFormatter.dateFormat = "MMM d"
    monthDayDateFormatter.timeZone = TimeZone(abbreviation: "KST")  // KST
    let monthDayYearDateFormatter = DateFormatter()
    monthDayYearDateFormatter.dateFormat = "MMM d, yyyy"
    monthDayYearDateFormatter.timeZone = TimeZone(abbreviation: "KST")  // KST
    
    var startDateString = monthDayDateFormatter.string(from: startOfWeekDate)
    var endDateString = monthDayYearDateFormatter.string(from: endOfWeekDate)
    
    if calendar.isDate(startOfWeekDate, equalTo: endOfWeekDate, toGranularity: .month) {
        let dayYearDateFormatter = DateFormatter()
        
        dayYearDateFormatter.dateFormat = "d, yyyy"
        dayYearDateFormatter.timeZone = TimeZone(abbreviation: "KST")  // KST
        endDateString = dayYearDateFormatter.string(from: endOfWeekDate)
    }
    
    if !calendar.isDate(startOfWeekDate, equalTo: endOfWeekDate, toGranularity: .year) {
        startDateString = monthDayYearDateFormatter.string(from: startOfWeekDate)
    }
    
    return String(format: "%@–%@", startDateString, endDateString)
}

private func createMonthDayDateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "MM/dd"
    dateFormatter.timeZone = TimeZone(abbreviation: "KST")  // KST
    
    return dateFormatter
}

func createChartDateLastUpdatedLabel(_ dateLastUpdated: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateStyle = .medium
    dateFormatter.timeZone = TimeZone(abbreviation: "KST")  // KST
    
    return "last updated on \(dateFormatter.string(from: dateLastUpdated))"
}

func createHorizontalAxisMarkers(lastDate: Date = Date(), useWeekdays: Bool = true) -> [String] {
    let calendar: Calendar = .current
    let weekdayTitles = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var titles: [String] = []
    
    if useWeekdays {
        titles = weekdayTitles
        
        let weekday = calendar.component(.weekday, from: lastDate)
        
        return Array(titles[weekday..<titles.count]) + Array(titles[0..<weekday])
    } else {
        let numberOfTitles = weekdayTitles.count
        let endDate = lastDate
        let startDate = calendar.date(byAdding: DateComponents(day: -(numberOfTitles - 1)), to: endDate)!
        
        let dateFormatter = createMonthDayDateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")  // KST

        var date = startDate
        
        while date <= endDate {
            titles.append(dateFormatter.string(from: date))
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        
        return titles
    }
}

func createHorizontalAxisMarkers(for dates: [Date]) -> [String] {
    let dateFormatter = createMonthDayDateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "KST")  // KST
    
    return dates.map { dateFormatter.string(from: $0) }
}

