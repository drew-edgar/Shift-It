//
//  Event.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import Foundation
import SwiftUI // For Color
import SwiftData

@Model
class Event: Identifiable {
    var id: UUID
    var name: String
    var startTime: Date
    var endTime: Date
    var isDurationLocked: Bool
    var isTimeLocked: Bool
    var icon: String // Assuming icon is represented as a String, such as a system icon name
    var colorHex: String
    var isRepeating: Bool
    var isComplete: Bool
    var isPassed: Bool
    
    init(name: String, startTime: Date, endTime: Date, isDurationLocked: Bool, isTimeLocked: Bool, icon: String, color: Color, isRepeating: Bool, isComplete: Bool, isPassed: Bool) {
        self.id = UUID()
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.isDurationLocked = isDurationLocked
        self.isTimeLocked = isTimeLocked
        self.icon = icon
        self.colorHex = color.toHex() ?? "#FFFFFF"
        self.isRepeating = isRepeating
        self.isComplete = isComplete
        self.isPassed = isPassed
    }
    
    var color: Color {
        get {
            Color.fromHex(colorHex)  // Convert hex string back to Color
        }
        set {
            colorHex = newValue.toHex() ?? "#FFFFFF"  // Update hex string when the color changes
        }
    }
    // Computed property to calculate duration
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
    
    // Static function to create dummy events
    static func createDummyEvents() -> [Event] {
        // Define some date formatters to create dummy dates
        
        // Example times
        let startDate1 = timeFromHour(hour: 9)!
        let endDate1 = timeFromHour(hour: 10)!
        
        let startDate2 = timeFromHHmm(with: "14:00")!
        let endDate2 = timeFromHHmm(with: "15:30")!
        
        let startDate3 = timeFromHHmm(with: "18:00")!
        let endDate3 = timeFromHHmm(with: "19:00")!
        
        
        
        return [
            Event(
                name: "Work",
                startTime: startDate1,
                endTime: endDate1,
                isDurationLocked: true,
                isTimeLocked: false,
                icon: "calendar",
                color: Color.blue,
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
                color: Color.green,
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
                color: Color.red,
                isRepeating: false,
                isComplete: false,
                isPassed: true
            )
        ]
    }
}
