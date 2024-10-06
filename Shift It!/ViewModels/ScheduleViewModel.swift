//
//  ScheduleViewModel.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI
import SwiftData
import Combine

class ScheduleViewModel: ObservableObject {

    @Published var showEventEditModal = false;
    @Published var showAddEditModal = false;
    @Published var showEventPopup = false;
    @Published var selectedEvent: Event?
    
    func addEvent(name: String, startTime: Date, endTime: Date, isDurationLocked: Bool, isTimeLocked: Bool, icon: String, color: Color, isRepeating: Bool, isComplete: Bool, isPassed: Bool, context: ModelContext) {
        let newEvent = Event(name: name, startTime: startTime, endTime: endTime, isDurationLocked: isDurationLocked, isTimeLocked: isTimeLocked, icon: icon, color: color, isRepeating: isRepeating, isComplete: isComplete, isPassed: isPassed)
        context.insert(newEvent)
        do {
            try context.save()
            print("Event added: \(newEvent.name)")
        } catch {
            print("Failed to save new event: \(error)")
        }
    }
    
    func deleteEvent(_ event: Event, context: ModelContext) {
        context.delete(event)
        do {
            try context.save()
            print("Deleted event.")
        } catch {
            print("Failed to delete event: \(error)")
        }
    }
    
    func updateEvent(_ event: Event, name: String, startTime: Date, endTime: Date, isDurationLocked: Bool, isTimeLocked: Bool, icon: String, color: Color, isRepeating: Bool, isComplete: Bool, isPassed: Bool, context: ModelContext) {
        event.name = name
        event.startTime = startTime
        event.endTime = endTime
        event.isDurationLocked = isDurationLocked
        event.isTimeLocked = isTimeLocked
        event.icon = icon
        event.colorHex = color.toHex() ?? "#FFFFFF"
        event.isRepeating = isRepeating
        event.isComplete = isComplete
        event.isPassed = isPassed
        
        do {
            try context.save()
        } catch {
            print("Failed to update event: \(error)")
        }
    }
    
    func initializeDummyEvents(context: ModelContext) {
        let dummyEvents = Event.createDummyEvents()
        
        for event in dummyEvents {
            context.insert(event)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save dummy events: \(error)")
        }
    }
}
