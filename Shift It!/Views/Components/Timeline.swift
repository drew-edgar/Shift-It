//
//  Timeline.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI
import SwiftData

struct Timeline: View {
    
    @EnvironmentObject var viewModel: ScheduleViewModel
    @Environment(\.modelContext) private var context: ModelContext
    @Query(sort: \Event.startTime, order: .forward) var events: [Event] {
        didSet {
            print("Fetched \(events.count) events.")
        }
    }
    
    @State private var selectedEvent: Event?
    @State private var showModal = false
  
    var bedtime = 23
    var wakeUp = 7
    let horizontalSpacing = 12.0
    
    var body: some View {
            
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: horizontalSpacing) {
                Text("07:00")
                Image(systemName: "sun.horizon")
            }
            
            if !events.isEmpty {
                ForEach(0..<3) { i in
                    HStack(spacing: horizontalSpacing) {
                        HStack {
                            CircleStyle(index: i, totalCircles: 3)
                        }.frame(width: 48)
                        
                        if i == 1 {
                            // Safely check if events are non-empty before accessing the first element
                            if let firstEvent = events.first {
                                Text(formatDuration(dayTimeInterval(from: firstEvent.startTime, until: wakeUp)!))
                                    .font(.smallText)
                            }
                        }
                    }
                }
                
                ForEach(Array(events.enumerated()), id: \.element.id) { (index, event) in
                    HStack(spacing: horizontalSpacing) {
                        VStack {
                            Text(formatTimeOfDay(from: event.startTime))
                            Spacer().frame(height: 45)
                            Text(formatTimeOfDay(from: event.endTime))
                        }
                        EventCapsule(event: event)
                            .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.12), radius: 4, y: 4)
                    }
                    
                    if index < events.count - 1 {
                        let nextEvent = events[index + 1]
                        ForEach(0..<5) { i in
                            HStack(spacing: horizontalSpacing) {
                                HStack {
                                    CircleStyle(index: i, totalCircles: 5)
                                }.frame(width: 48)
                                
                                if i == 2 {
                                    Text(formatDuration(nextEvent.startTime.timeIntervalSince(event.endTime)))
                                        .font(.smallText)
                                }
                            }
                        }
                    }
                }

                if let lastEvent = events.last {
                    ForEach(0..<3) { i in
                        HStack(spacing: horizontalSpacing) {
                            HStack {
                                CircleStyle(index: i, totalCircles: 3)
                            }.frame(width: 48)
                            
                            if i == 1 {
                                Text(formatDuration(dayTimeInterval(from: lastEvent.endTime, until: bedtime)!))
                                    .font(.smallText)
                            }
                        }
                    }
                }
            }

            HStack(spacing: horizontalSpacing) {
                Text("23:00")
                Image(systemName: "moon.fill")
            }
        }
        .foregroundStyle(Color.main)
        .onAppear {
            viewModel.initializeDummyEvents(context: context)
        }
    }
}


struct CircleStyle: View {
    var index: Int
    var totalCircles: Int

    var body: some View {
        Circle()
            .fill((index == 0 || index >= totalCircles-1) ? Color.alternate : Color.headerBackground)
            .frame(width: 8, height: 8)
            .padding(2)
    }
}

#Preview {
    let viewModel = ScheduleViewModel()
    Timeline()
        .modelContainer(for: Event.self, inMemory: true)
        .environmentObject(viewModel)
}


