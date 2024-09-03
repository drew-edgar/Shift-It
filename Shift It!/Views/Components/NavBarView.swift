//
//  NavBarView.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct NavBarView: View {
    var body: some View {
        ZStack {
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "clock")
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "flame")
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "gear")
                })
            }
        }
    }
}

#Preview {
    NavBarView()
}
