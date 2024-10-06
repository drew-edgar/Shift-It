//
//  SettingsView.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var wakeUpTime: Date = timeFromHour(hour: 7)!
    @State private var bedTime: Date = timeFromHour(hour: 23)!

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Start of day")
                    Spacer()
                    DatePicker("", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                HStack {
                    Text("End of day")
                    Spacer()
                    DatePicker("", selection: $bedTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
        }
    }
}


#Preview {
    SettingsView()
}
