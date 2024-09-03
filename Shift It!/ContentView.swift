//
//  ContentView.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        ZStack {
            TabView() {
                Group {
                    ScheduleView()
                        .tabItem {
                            VStack {
                                Image(systemName: "clock.fill").font(.iconText)
                                Text("Schedule").font(.smallText)
                            }
                        }
                    StreakView()
                        .tabItem {
                            VStack {
                                Image(systemName: "flame.fill").font(.iconText)
                                Text("Streak").font(.smallText)
                            }
                        }
                    SettingsView()
                        .tabItem {
                            VStack {
                                Image(systemName: "gear").font(.iconText)
                                Text("Settings").font(.smallText)
                            }
                        }
                }
//                .toolbarBackground(.headerBackground, for: .tabBar)
//                .toolbarBackground(.visible, for: .tabBar)
            }


            
        }

    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
