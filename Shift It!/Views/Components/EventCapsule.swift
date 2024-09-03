//
//  EventCapsule.swift
//  Shift It!
//
//  Created by Drew Edgar on 03/09/2024.
//

import SwiftUI

struct EventCapsule: View {
    @State private var isChecked = false
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "clock").font(.iconText).foregroundStyle(Color.main)
                VStack (alignment:.leading){
                    Text("4 hrs").font(.smallText).foregroundColor(Color("MainColor"))
                    Text("Work").font(.strongText).foregroundStyle(Color.black)
                    HStack {
                        Image(systemName: "lock")
                        Text("Time + Duration")
                    }.font(.smallText).foregroundStyle(Color.main)
                }
                
                Spacer()
                Toggle(isOn: $isChecked) {
                    
                }.toggleStyle(.checkcircle)

            }
        }
        .padding()
        .background(Color.headerBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))

    }
}

#Preview {
    EventCapsule()
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
