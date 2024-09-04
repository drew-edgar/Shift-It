//
//  Event.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import Foundation
import SwiftUI // For Color

class Event: Identifiable {
    
    init(name: String, startTime: Date, endTime: Date, isDurationLocked: Bool, isTimeLocked: Bool, icon: String, colour: Color, isRepeating: Bool, isComplete: Bool, isPassed: Bool) {
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.isDurationLocked = isDurationLocked
        self.isTimeLocked = isTimeLocked
        self.icon = icon
        self.colour = colour
        self.isRepeating = isRepeating
        self.isComplete = isComplete
        self.isPassed = isPassed
    }
    
    let id = UUID()
    var name: String
    var startTime: Date
    var endTime: Date
    var isDurationLocked: Bool
    var isTimeLocked: Bool
    var icon: String // Assuming icon is represented as a String, such as a system icon name
    var colour: Color
    var isRepeating: Bool
    var isComplete: Bool
    var isPassed: Bool
    
    // Computed property to calculate duration
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
    
    // Static function to create dummy events
    static func createDummyEvents() -> [Event] {
        // Define some date formatters to create dummy dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // Example dates
        let startDate1 = dateFormatter.date(from: "2024-09-03 09:00:00")!
        let endDate1 = dateFormatter.date(from: "2024-09-03 10:00:00")!
        
        let startDate2 = dateFormatter.date(from: "2024-09-03 14:00:00")!
        let endDate2 = dateFormatter.date(from: "2024-09-03 15:30:00")!
        
        let startDate3 = dateFormatter.date(from: "2024-09-03 18:00:00")!
        let endDate3 = dateFormatter.date(from: "2024-09-03 19:00:00")!
        
        
        
        return [
            Event(
                name: "Work",
                startTime: startDate1,
                endTime: endDate1,
                isDurationLocked: true,
                isTimeLocked: false,
                icon: "calendar",
                colour: Color.blue,
                isRepeating: false,
                isComplete: false,
                isPassed: false
            ),
            Event(
                name: "Work out",
                startTime: startDate2,
                endTime: endDate2,
                isDurationLocked: false,
                isTimeLocked: true,
                icon: "clock",
                colour: Color.green,
                isRepeating: true,
                isComplete: false,
                isPassed: false
            ),
            Event(
                name: "Study",
                startTime: startDate3,
                endTime: endDate3,
                isDurationLocked: false,
                isTimeLocked: false,
                icon: "star",
                colour: Color.red,
                isRepeating: false,
                isComplete: false,
                isPassed: true
            )
        ]
    }
}
