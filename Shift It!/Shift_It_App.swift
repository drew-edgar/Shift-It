//
//  Shift_It_App.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI
import SwiftData

@main
struct Shift_It_App: App {
    @StateObject private var scheduleViewModel = ScheduleViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Event.self])
                .environmentObject(scheduleViewModel)
        }

    }
}
