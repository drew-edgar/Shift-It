//
//  DateTimeHelpers.swift
//  Shift It!
//
//  Created by Drew Edgar on 04/09/2024.
//

import Foundation

// Given a date, returns the time of day in "HH:mm" format
public func formatTimeOfDay(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}

// Given a time interval, formats it into hours and minutes
public func formatDuration(_ duration: TimeInterval) -> String {
    let hours = Int(duration) / 3600
    let minutes = (Int(duration) % 3600) / 60
    return "\(hours)h\(minutes != 0 ? " \(minutes)m" : "")"
}

public func dayTimeInterval(from date: Date, until hour: Int) -> TimeInterval?
{
    let calendar = Calendar.current
    var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    

    dateComponents.hour = hour
    dateComponents.minute = 0
    dateComponents.second = 0
    

    guard let hourTime = calendar.date(from: dateComponents) else {
        return nil
    }
    
    var timeInterval = hourTime.timeIntervalSince(date)
    if timeInterval < 0 {
        timeInterval = date.timeIntervalSince(hourTime)
    }
    
    return timeInterval
}

public func timeFromHour(hour: Int) -> Date? {
    let calendar = Calendar.current
    var dateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
    

    dateComponents.hour = hour
    dateComponents.minute = 0
    dateComponents.second = 0
    

    guard let hourTime = calendar.date(from: dateComponents) else {
        return nil
    }
    
    return hourTime
}


func timeFromHHmm(with timeString: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    formatter.locale = Locale(identifier: "en_US_POSIX")
    
    // Get current date
    let currentDate = Date()
    let calendar = Calendar.current
    
    // Extract current year, month, and day
    let currentComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)

    // Parse the time string to get hour and minute
    if let timeDate = formatter.date(from: timeString) {
        let timeComponents = calendar.dateComponents([.hour, .minute], from: timeDate)

        // Create a new DateComponents object with the current date components and the parsed hour and minute
        var combinedComponents = DateComponents()
        combinedComponents.year = currentComponents.year
        combinedComponents.month = currentComponents.month
        combinedComponents.day = currentComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute

        // Return the combined date
        return calendar.date(from: combinedComponents)
    }
    
    return nil
}



extension Date {
    func startOfWeek(using calendar: Calendar) -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components) ?? self
    }
    
    func getAllDatesOfWeek(using calendar: Calendar = Calendar.current) -> [Date] {
        let startOfWeek = self.startOfWeek(using: calendar)
        return (0...6).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    func dayOfMonth(using calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(.day, from: self)
    }
    
    func dayOfWeekLetter(using calendar: Calendar = Calendar.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        let dayOfWeek = dateFormatter.string(from: self)
        return String(dayOfWeek.prefix(1)).uppercased()
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yy"
        return dateFormatter.string(from: self)
    }
    
    func formattedDateNoDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yy"
        return dateFormatter.string(from: self)
    }

    
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
    
    func isPreviousDay(from otherDate: Date) -> Bool {
        let calendar = Calendar.current
        // Calculate the date for the next day from 'self'
        if let nextDay = calendar.date(byAdding: .day, value: 1, to: self) {
            return calendar.isDate(nextDay, inSameDayAs: otherDate)
        }
        return false
    }
    
    func isNextDay(from otherDate: Date) -> Bool {
        let calendar = Calendar.current
        // Calculate the date for the previous day from 'self'
        if let previousDay = calendar.date(byAdding: .day, value: -1, to: self) {
            return calendar.isDate(previousDay, inSameDayAs: otherDate)
        }
        return false
    }
}
