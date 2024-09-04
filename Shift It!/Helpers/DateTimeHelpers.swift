//
//  DateTimeHelpers.swift
//  Shift It!
//
//  Created by Drew Edgar on 04/09/2024.
//

import Foundation

public func formatTimeOfDay(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}

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


