//
//  EventPopupView.swift
//  Shift It!
//
//  Created by Drew Edgar on 06/10/2024.
//

import SwiftUI

struct EventPopupView: View {
    var event: Event
    @Binding var showPopup: Bool
    @EnvironmentObject var viewModel: ScheduleViewModel

    var body: some View {
        VStack {
            HStack {
//                Image(systemName: "trash").font(.day)
                Button(action: {viewModel.showEventEditModal = true}, label: {Text("Edit...").font(.popup)})
                Spacer()
            }
            .foregroundStyle(Color.alternate)
                .padding(6.0)
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10).frame(width: 40, height: 40).foregroundStyle(.headerBackground)
                    Image(systemName: event.icon).font(.iconText).foregroundStyle(event.color)
                }
                Text(event.name).font(.titleText).foregroundStyle(Color.black)
                Spacer()
                if event.isRepeating {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                    Text("Daily").font(.popup)
                }
            }
            .padding(8.0)
            HStack {
                event.isTimeLocked ? Image(systemName: "lock") : Image(systemName: "lock.open")
                Text("\(formatTimeOfDay(from: event.startTime)) - \(formatTimeOfDay(from: event.endTime))")
                Spacer()
                event.isDurationLocked ? Image(systemName: "lock") : Image(systemName: "lock.open")
                Text("\(formatDuration(event.duration))")
            }
            .font(.popup)
            .padding(6.0)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
//        .offset(y: showPopup ? 0 : UIScreen.main.bounds.height) // Initially off the screen
//        .animation(.spring(), value: showPopup) // Rising animation

    }
}


#Preview {
    @Previewable @State var showPopup = true;
    let viewModel = ScheduleViewModel()
    EventPopupView(event:Event.createDummyEvents()[0], showPopup: $showPopup)
        .environmentObject(viewModel)
}
