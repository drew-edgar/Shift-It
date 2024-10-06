//
//  ScheduleHeader.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct ScheduleHeader: View {
    @State private var selectedDayIndex: Int = 3
    @State private var currentWeekOffset: Int = 0
    @State private var isDragging: Bool = false
    
    var body: some View {
        let currentWeekDates = generateWeekDates(weekOffset: currentWeekOffset)
        
        VStack {
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "calendar").font(.iconText)
                })
                Spacer()
                VStack {
                    if currentWeekDates[selectedDayIndex].isSameDay(as: Date()) {
                        Text("Today").font(.titleText)
                        Text(currentWeekDates[selectedDayIndex].formattedDate()).font(.subtitle).foregroundColor(Color("MainColor")).uppercaseStyle()
                    } else if currentWeekDates[selectedDayIndex].isPreviousDay(from: Date()) {
                        Text("Yesterday").font(.titleText)
                        Text(currentWeekDates[selectedDayIndex].formattedDate()).font(.subtitle).foregroundColor(Color("MainColor")).uppercaseStyle()
                    } else if currentWeekDates[selectedDayIndex].isNextDay(from: Date()) {
                        Text("Tomorrow").font(.titleText)
                        Text(currentWeekDates[selectedDayIndex].formattedDate()).font(.subtitle).foregroundColor(Color("MainColor")).uppercaseStyle()
                    } else {
                        Text(currentWeekDates[selectedDayIndex].formattedDate()).font(.titleText).foregroundColor(Color.black)
                    }

                }
                Spacer()
                Image(systemName: "calendar").foregroundColor(Color("InvisibleColor")).font(.iconText)
            }
            .frame(height: 44)
            .padding(.horizontal, 22.0)

            
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:10) {
                        Spacer()
                        ForEach(0..<currentWeekDates.count, id: \.self) { index in
                            VStack(spacing: 4) {
                                Text(currentWeekDates[index].dayOfWeekLetter())
                                    .font(.day)
                                ZStack {
                                    Circle().fill(selectedDayIndex == index ? Color.alternate : Color.invisible).frame(height: 35)
                                    Text("\(currentWeekDates[index].dayOfMonth())")
                                        .font(.strongText).foregroundStyle(selectedDayIndex == index ? Color.headerBackground : Color.alternate)
                                }
                            }
                            .frame(width: 40)
                            .onTapGesture {
                                selectedDayIndex = index
                            }

                        }
                        Spacer()
                    }
                    .foregroundColor(Color("AlternateColor"))
                }
                .content.offset(x: 0)
                
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            let screenWidth = UIScreen.main.bounds.width
                            let threshold = screenWidth / 3
                            
                            if value.translation.width < -threshold {
                                withAnimation(.easeIn) {
                                    nextWeek()
                                }
                            } else if value.translation.width > threshold {
                                withAnimation(.easeIn) {
                                    previousWeek()
                                }
                            }
                        }
                )
        }
        .padding(.bottom, 8.0)

        

    }
    
    func generateWeekDates(weekOffset: Int) -> [Date] {
        let startOfCurrentWeek = Date().startOfWeek(using: .current).addingTimeInterval(Double(weekOffset) * 7 * 24 * 60 * 60)
        return startOfCurrentWeek.getAllDatesOfWeek()
    }
    
    func nextWeek() {
        currentWeekOffset += 1
    }
    
    func previousWeek() {
        currentWeekOffset -= 1
    }
    
    func itemWidth(for screenWidth: CGFloat) -> CGFloat {
        return screenWidth / 8
    }
    
}

#Preview {
    ScheduleHeader()
}


