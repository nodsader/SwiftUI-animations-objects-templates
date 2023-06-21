//
//  MainView.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 21/06/2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var liked: [Bool] = [false, false, false]
    
    var inActiveFace = Color(red: 255/255, green: 255/255, blue: 192/255)
    var inActiveHeart = Color(red: 192/255, green: 128/255, blue: 128/255)
    var inActiveFolder = Color(red: 128/255, green:  160/255, blue: 192/255)
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                CustomButton(systemImage: "heart.fill", type: liked[0], activeTint: .pink, inActiveTint: inActiveHeart) {
                    liked[0].toggle()
                }
                
                CustomButton(systemImage: "face.smiling.inverse", type: liked[1], activeTint: .yellow, inActiveTint: inActiveFace) {
                    liked[1].toggle()
                }
                
                CustomButton(systemImage: "folder.fill", type: liked[2], activeTint: .blue, inActiveTint: inActiveFolder) {
                    liked[2].toggle()
                }
        }
    }
}

    
  @ViewBuilder
    func CustomButton(systemImage: String, type: Bool, activeTint: Color, inActiveTint: Color, whenTap: @escaping () -> ()) -> some View {
        Button(action: whenTap) {
            Image(systemName: systemImage)
                .font(.title3)
                .particuleEffect(
                    systemImage: systemImage,
                    font: .title3,
                    type: type,
                    activeTint: activeTint,
                    inActiveTint: inActiveTint
                )
                .foregroundColor(type ? activeTint : inActiveTint)
                .padding(.horizontal, 20)
                .padding(.vertical, 9)
                .background{
                    Capsule()
                        .fill(type ? activeTint.opacity(0.20) : Color(.black))
                }
        }
    }
}
