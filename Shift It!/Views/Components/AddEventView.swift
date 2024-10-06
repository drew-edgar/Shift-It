//
//  EditEventView.swift
//  Shift It!
//
//  Created by Drew Edgar on 06/10/2024.
//

import SwiftUI
import SwiftData

struct AddEventView: View {
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
    
    init(onSave: @escaping (Event) -> Void) {
        _name = State(initialValue: "")
        _startTime = State(initialValue: timeFromHHmm(with: "07:00")!)
        _endTime = State(initialValue: timeFromHHmm(with: "08:00")!)
        _icon = State(initialValue: "clock")
        _color = State(initialValue: .red)
        _isDurationLocked = State(initialValue: false)
        _isTimeLocked = State(initialValue: false)
        _isRepeating = State(initialValue: false)
        self.onSave = onSave
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
            .navigationBarTitle("Add Event", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    // Save the changes
                    let event = Event(name: name, startTime: startTime, endTime: endTime, isDurationLocked: isDurationLocked, isTimeLocked: isTimeLocked, icon: icon, color: color, isRepeating: isRepeating, isComplete: false, isPassed: false)
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
    AddEventView(onSave: { Event in
        return
    })
//        .modelContainer(for: Event.self, inMemory: true)
        .environmentObject(viewModel)
}
