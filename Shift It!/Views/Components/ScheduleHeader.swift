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
            .padding(.bottom, 6.0)

            
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

extension Date {
    func startOfWeek(using calendar: Calendar) -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components) ?? self
    }
    
    func getAllDatesOfWeek(using calendar: Calendar = Calendar.current) -> [Date] {
        let startOfWeek = self.startOfWeek(using: calendar)
        return (0...6).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    func dayOfMonth(using calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(.day, from: self)
    }
    
    func dayOfWeekLetter(using calendar: Calendar = Calendar.current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        let dayOfWeek = dateFormatter.string(from: self)
        return String(dayOfWeek.prefix(1)).uppercased()
    }
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yy"
        return dateFormatter.string(from: self)
    }
    
    func formattedDateNoDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yy"
        return dateFormatter.string(from: self)
    }

    
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
    
    func isPreviousDay(from otherDate: Date) -> Bool {
        let calendar = Calendar.current
        // Calculate the date for the next day from 'self'
        if let nextDay = calendar.date(byAdding: .day, value: 1, to: self) {
            return calendar.isDate(nextDay, inSameDayAs: otherDate)
        }
        return false
    }
    
    func isNextDay(from otherDate: Date) -> Bool {
        let calendar = Calendar.current
        // Calculate the date for the previous day from 'self'
        if let previousDay = calendar.date(byAdding: .day, value: -1, to: self) {
            return calendar.isDate(previousDay, inSameDayAs: otherDate)
        }
        return false
    }
}
