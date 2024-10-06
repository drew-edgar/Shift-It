//
//  EventCapsule.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct EventCapsule: View {
    @State private var isChecked = false
    @EnvironmentObject var viewModel: ScheduleViewModel
    var event: Event
    
    var body: some View {
        Button(action: {
            viewModel.showEventPopup = true
            viewModel.selectedEvent = event
            print("showEvent: \(viewModel.showEventEditModal)")
            print("selectedEvent: \(viewModel.selectedEvent!.name)")
        }) {
            ZStack {
                HStack {
                    Image(systemName: event.icon).font(.iconText).foregroundStyle(event.color)
                    VStack (alignment:.leading){
                        Text(formatDuration(event.duration)).font(.smallText).foregroundColor(Color("MainColor"))
                        Text(event.name).font(.strongText).foregroundStyle(Color.black)
                        HStack {
                            if event.isTimeLocked || event.isDurationLocked{
                                Image(systemName: "lock")
                            } else {
                                Image(systemName: "lock.open")
                            }
                            if event.isTimeLocked && event.isDurationLocked {
                                Text("Time + Duration")
                            } else if event.isTimeLocked {
                                Text("Time")
                            } else if event.isDurationLocked {
                                Text("Duration")
                            }
                            
                        }.font(.smallText).foregroundStyle(Color.main)
                    }
                    
                    Spacer()
                    Toggle(isOn: $isChecked) {
                        
                    }.toggleStyle(.checkcircle)
                        .onChange(of: isChecked) { newValue in
                            event.isComplete = newValue
                        }
                }
            }
            .padding()
            .background(Color.headerBackground)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }

    }
}

#Preview {
    let viewModel = ScheduleViewModel()
    EventCapsule(event: Event.createDummyEvents()[0])
        .environmentObject(viewModel)
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Circle()
                .stroke(.alternate, lineWidth: 5)
                .fill(Color.headerBackground)
                .frame(width: 25, height: 25)
                .overlay {
                    Image(systemName: configuration.isOn ? "circle.fill" : "")
                }
                .foregroundStyle(Color.alternate)
                .onTapGesture {
                        configuration.isOn.toggle()
                }
            
            configuration.label
        }
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkcircle: CheckboxToggleStyle {CheckboxToggleStyle() }
}
