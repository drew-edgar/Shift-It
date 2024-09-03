//
//  ScheduleHeader.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct ScheduleHeader: View {
    let dates: [Date] = {
        let calendar = Calendar.current
        let today = Date()
        let lower = Calendar.current.date(byAdding: .day, value: -15, to: Date())
        return (0..<30).compactMap{ calendar.date(byAdding: .day, value: $0, to: lower ?? Date()) }
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "calendar").font(.iconText)
                })
                Spacer()
                VStack {
                    Text("Today").font(.titleText)
                    Text("September 28 2024").font(.subtitle).foregroundColor(Color("MainColor")).uppercaseStyle()
                }
                Spacer()
                Image(systemName: "calendar").foregroundColor(Color("InvisibleColor")).font(.iconText)
            }
            .padding(.horizontal, 22.0)
            .padding(.bottom, 6.0)

            
            GeometryReader { geometry in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:10) {
                        ForEach(dates, id: \.self) { date in
                            VStack {
                                Text(dayOfWeekLetter(from: date))
                                    .font(.day)
                                Text(dayOfMonth(from: date))
                                    .font(.strongText)
                            }
                            .frame(width: itemWidth(for: geometry.size.width), height: 60)
                        }
                    }
                    .foregroundColor(Color("AlternateColor"))
                }
            }
            .frame(height: 65)
        }

        

    }
    
    func dayOfWeekLetter(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        let dayOfWeek = dateFormatter.string(from: date)
        return String(dayOfWeek.prefix(1)).uppercased()
    }
    
    // Helper function to get the numeric day of the month
    func dayOfMonth(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    func itemWidth(for screenWidth: CGFloat) -> CGFloat {
        return screenWidth / 8
    }
    
}

#Preview {
    ScheduleHeader()
}
