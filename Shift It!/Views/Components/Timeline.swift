//
//  Timeline.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct Timeline: View {
    var body: some View {
        HStack {
            VStack {
                Text("07:00").font(.time)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Text("09:00").font(.time)
                Text("13:00").font(.time)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Text("16:00").font(.time)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Circle().frame(width: 8, height: 8)
                Text("23:00")
            }.font(.time)
            VStack(alignment: .leading) {
                Image(systemName: "sun.horizon")
                Text("2 hrs").font(.smallText)
                EventCapsule()
                Text("1 hrs").font(.smallText)
                EventCapsule()
                Text("7 hrs").font(.smallText)
                Image(systemName: "moon.fill")
            }.foregroundStyle(Color.main)
        }
    }
}

#Preview {
    Timeline()
}
