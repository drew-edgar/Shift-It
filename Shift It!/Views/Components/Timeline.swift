//
//  Timeline.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct Timeline: View {
    
    @StateObject private var viewModel = ScheduleViewModel()
  
    var bedtime = 23
    var wakeUp = 7
    let horizontalSpacing = 12.0
    var body: some View {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: horizontalSpacing) {
                    Text("07:00")
                    Image(systemName: "sun.horizon")
                }
                
                if (viewModel.events.count > 0) {
                    
                    ForEach(0..<3) { i in
                        HStack(spacing: horizontalSpacing) {
                            HStack {
                                CircleStyle(index: i, totalCircles: 3)
                            }.frame(width:48)
                            
                            if i == 1 {
                                Text(formatDuration(dayTimeInterval(from: viewModel.events[0].startTime, until: wakeUp)!))
                                    .font(.smallText)
                            }
                        }
                    }
                    
                    ForEach(viewModel.events.indices, id: \.self) { j in
                        HStack(spacing: horizontalSpacing) {
                            VStack {
                                Text(formatTimeOfDay(from: viewModel.events[j].startTime))
                                Spacer().frame(height: 45)
                                Text(formatTimeOfDay(from: viewModel.events[j].endTime))
                            }
                            EventCapsule(event: viewModel.events[j])
                                .shadow(color: Color(hue: 1.0, saturation: 0.0, brightness: 0.0, opacity: 0.12),radius: 4, y: 4)
                        }
                        
                        if j < viewModel.events.count - 1 {
                            ForEach(0..<5) { i in
                                HStack(spacing: horizontalSpacing) {
                                    HStack {
                                        CircleStyle(index: i, totalCircles: 5)
                                    }.frame(width:48)
                                    
                                    if i == 2 {
                                        Text(formatDuration(viewModel.events[j+1].startTime.timeIntervalSince(viewModel.events[j].endTime)))
                                            .font(.smallText)
                                    }
                                }
                            }
                        }
                    }
                    
                    
                    ForEach(0..<3) { i in
                        HStack(spacing: horizontalSpacing) {
                            HStack {
                                CircleStyle(index: i, totalCircles: 3)
                            }.frame(width:48)
                            
                            if i == 1 {
                                Text(formatDuration(dayTimeInterval(from: viewModel.events.last!.endTime, until: bedtime)!))
                                    .font(.smallText)
                            }
                        }
                    }
                }
                
                HStack(spacing: horizontalSpacing) {
                    Text("23:00")
                    Image(systemName: "moon.fill")
                }
            }.foregroundStyle(Color.main)
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
    Timeline()
}


