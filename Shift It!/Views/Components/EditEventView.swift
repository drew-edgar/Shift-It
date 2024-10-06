//
//  EditEventView.swift
//  Shift It!
//
//  Created by Drew Edgar on 06/10/2024.
//

import SwiftUI
import SwiftData

struct EditEventView: View {
    @State var event: Event
    @State private var name: String
    @State private var endTime: Date
    @State private var startTime: Date
    @State private var icon: String
    @State private var color: Color
    @State private var isTimeLocked: Bool
    @State private var isRepeating: Bool
    @State private var isDurationLocked: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var onSave: (Event) -> Void
    var onDelete: (Event) -> Void
    
    init(event: Event, onSave: @escaping (Event) -> Void, onDelete: @escaping (Event) -> Void) {
        self.event = event
        _name = State(initialValue: event.name)
        _startTime = State(initialValue: event.startTime)
        _endTime = State(initialValue: event.endTime)
        _icon = State(initialValue: event.icon)
        _color = State(initialValue: event.color)
        _isDurationLocked = State(initialValue: event.isDurationLocked)
        _isTimeLocked = State(initialValue: event.isTimeLocked)
        _isRepeating = State(initialValue: event.isRepeating)
        self.onSave = onSave
        self.onDelete = onDelete
    }
    
    var body: some View {
        NavigationView {
            Form {
                    Section(header: Text("Event Details")) {
                        TextField("Name", text: $name)
                        
                        DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                        DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                        
                        ColorPicker("Event Color", selection: $color)
                    }
                    
                    Section(header: Text("Scheduling Settings")) {
                        Toggle("Duration Locked", isOn: $isDurationLocked)
                        Toggle("Time Locked", isOn: $isTimeLocked)
                        Toggle("Recurring", isOn: $isRepeating)
                    }
            }
            .navigationBarTitle("Edit Event", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    dismiss()
                    onDelete(event)
                }, label: {
                    Text("Delete").foregroundColor(.red)
                }),
                trailing: Button(action: {
                        // Save the changes
                        event.name = name
                        event.startTime = startTime
                        event.endTime = endTime
                        event.icon = icon
                        event.color = color
                        event.isDurationLocked = isDurationLocked
                        event.isTimeLocked = isTimeLocked
                        event.isRepeating = isRepeating
                        onSave(event)
                        dismiss()
                }, label: {
                    Text("Save")
                })
            )
        }
    }
}

#Preview {
    let viewModel = ScheduleViewModel()
    EditEventView(event: Event.createDummyEvents()[0], onSave: { Event in
        return
    }, onDelete:  { Event in
        return
    })
//        .modelContainer(for: Event.self, inMemory: true)
        .environmentObject(viewModel)
}
