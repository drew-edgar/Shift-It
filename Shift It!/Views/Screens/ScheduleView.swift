//
//  ScheduleView.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI
import SwiftData

struct ScheduleView: View {
    @EnvironmentObject var viewModel: ScheduleViewModel
    
    @Query var events: [Event]
    @Environment(\.modelContext) private var context: ModelContext
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    ScheduleHeader()
                }
                .background(Color.headerBackground)
                .background(RoundedRectangle(cornerRadius: 15).fill(.headerBackground)                              .offset(CGSize(width: 0, height: 8))).zIndex(1)
                
                
                
                GeometryReader { geometry in
                    ZStack {
                        ScrollView {
                            Timeline()
                                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {}, label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: 48, height: 48)
                                        Image(systemName: "clock.arrow.circlepath")
                                            .foregroundColor(Color("ScreenBackgroundColor"))
                                            .font(.iconText)
                                        
                                    }
                                })
                                
                                Button(action: {
                                    viewModel.showAddEditModal = true
                                }, label: {
                                    ZStack {
                                        Circle()
                                            .frame(width: 48, height: 48)
                                        Image(systemName: "plus")
                                            .foregroundColor(Color("ScreenBackgroundColor"))
                                            .font(.iconText)
                                        
                                    }
                                })
                                
                                
                            }
                            .padding(.bottom, 28)
                            .padding(.trailing, 24)
                        }
                        
                    }
                    
                }
            }
            .sheet(isPresented: $viewModel.showEventEditModal) {
                if let selectedEvent = viewModel.selectedEvent {
                    EditEventView(event: selectedEvent, onSave: { updatedEvent in
                        viewModel.updateEvent(updatedEvent, name: updatedEvent.name, startTime: updatedEvent.startTime, endTime: updatedEvent.endTime, isDurationLocked: updatedEvent.isDurationLocked, isTimeLocked: updatedEvent.isTimeLocked, icon: updatedEvent.icon, color: updatedEvent.color, isRepeating: updatedEvent.isRepeating, isComplete: updatedEvent.isComplete, isPassed: updatedEvent.isPassed, context: context)
                        viewModel.showEventEditModal = false
                    }, onDelete: { eventToDelete in
                        viewModel.showEventEditModal = false
                        viewModel.showEventPopup = false
                        print("Modal dsimissed")
                        print("Events: \(events.count)")
                        viewModel.deleteEvent(eventToDelete, context: context)
                        
                        print("Events: \(events.count)")
                        
                    })
                }
            }
            .sheet(isPresented: $viewModel.showAddEditModal) {
                    AddEventView(onSave: { newEvent in
                        viewModel.addEvent(name: newEvent.name, startTime: newEvent.startTime, endTime: newEvent.endTime, isDurationLocked: newEvent.isDurationLocked, isTimeLocked: newEvent.isTimeLocked, icon: newEvent.icon, color: newEvent.color, isRepeating: newEvent.isRepeating, isComplete: newEvent.isComplete, isPassed: newEvent.isPassed, context: context)
                        viewModel.showAddEditModal = false
                    })
            }
            
            if viewModel.showEventPopup {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Dismiss popup when tapping outside
                            viewModel.showEventPopup = false
                        
                    }
                
                
                VStack {
                    Spacer()
                    EventPopupView(event: viewModel.selectedEvent!, showPopup: $viewModel.showEventPopup)
                        .transition(.move(edge: .bottom))
                        .onTapGesture {
                            // Prevent tap gesture from propagating to the overlay
                        }
                }
                .padding()
            }
        }
        
        
    }
    

}


#Preview {
    let viewModel = ScheduleViewModel()
    ScheduleView()
        .modelContainer(for: Event.self, inMemory: true)
        .environmentObject(viewModel)
}

