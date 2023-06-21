//
//  ParticuleEffect.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 21/06/2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func particuleEffect(systemImage: String, font: Font, type: Bool, activeTint: Color, inActiveTint: Color) -> some View {
        self
            .modifier(
             ParticuleModifier(systemImage: systemImage, font: font, type: type, activeTint: activeTint, inActiveTint: inActiveTint)
            )
    }
}

fileprivate struct ParticuleModifier: ViewModifier {
    var systemImage: String
    var font: Font
    var type: Bool
    var activeTint: Color
    var inActiveTint: Color
    
    @State private var particules: [Particule] = []
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                ZStack {
                    ForEach(particules) { particule in
                        Image(systemName: systemImage)
                            .foregroundColor(type ? activeTint : inActiveTint)
                            .scaleEffect(particule.scale)
                            .offset(x: particule.randomX, y: particule.randomY)
                            .opacity(particule.opacity)
                            .opacity(type ? 1 : 0)
                            .animation(.none, value: type)
                    }
                }
                .onAppear {
                    if particules.isEmpty {
                        for _ in 1...20 {
                            let particule = Particule()
                            particules.append(particule)
                        }
                    }
                }
                .onChange(of: type) { newValue in
                    if !newValue {
                        for index in particules.indices {
                            particules[index].reset()
                        }
                    } else {
                        for index in particules.indices {
                            let total: CGFloat = CGFloat(particules.count)
                            let progress: CGFloat = CGFloat(index) / total
                            
                            let maxX: CGFloat = (progress > 0.5) ? 100 : -100
                            let maxY: CGFloat = 60
                            
                            let randomX: CGFloat = ((progress > 0.7 ? progress - 0.7 : progress) * maxX)
                            let randomY: CGFloat = ((progress > 0.7 ? progress - 0.7 : progress) * maxY) + 25
                            let randomScale: CGFloat = .random(in: 0.35...1)
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                
                                let extraRandomX: CGFloat = (progress < 0.5 ? .random(in: 0...15) : .random(in: -15...0))
                                let extraRandomY: CGFloat = .random(in: 0...30)
                                
                                
                                particules[index].randomX = randomX + extraRandomX
                                particules[index].randomY = -randomY - extraRandomY
                            }
                            
                            withAnimation(.easeInOut(duration: 0.3)){
                                particules[index].scale = randomScale
                            }
                            
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.7).delay(0.20 + (Double(index) * 0.005))) {
                                particules[index].scale = 0.001
                            }
                            
                            
                        }
                    }
                }
            }
    }
}
