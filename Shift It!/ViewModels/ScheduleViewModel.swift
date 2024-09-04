//
//  ScheduleViewModel.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

class ScheduleViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedDay: Date = Date()

    init() {
        self.events = Event.createDummyEvents()
    }
}
