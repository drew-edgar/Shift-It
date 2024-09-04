//
//  ScheduleView.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct ScheduleView: View {
    var body: some View {
            VStack {
                ZStack {
                    ScheduleHeader()

                        .clipShape(.rect(bottomTrailingRadius: 15,topTrailingRadius: 0))
                }.background(Color.headerBackground)
                

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
                                
                                Button(action: {}, label: {
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
        
        
    }
    

}


#Preview {
    ScheduleView()
}

