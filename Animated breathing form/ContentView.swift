//
//  ContentView.swift
//  blob-breath
//
//  Created by Mathieu Moutarde on 27/06/2023.
//

//MARK: The values given in this code are given as an indication and can be modified according to your desires and your needs, do not hesitate to experiment with various parameters to adjust the effect according to what you want to create. This is just one example of a possible application.

import SwiftUI

struct ContentView: View {
    @State private var scale: CGFloat = 1.0
    @State var startAnimation: Bool = false
    @State private var isAnimating: Bool = false

        var body: some View {
            VStack {
                Button(action: {
                    isAnimating.toggle()
                    if isAnimating {
                        startAnimation = true
                        isAnimating = true
                        breatheIn()
                    } else {
                        stopAnimation()
                    }
                }) {
                    Text("Breath")
                        .fontWeight(.black)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                BlobedView()
            }
        }
        //MARK: Stop animation when button is clicked again
            func stopAnimation() {
                scale = 1.0
                isAnimating = false
                startAnimation = false
            }
    
        //MARK: This series of functions makes it possible to give a breathing rhythm to the form. In this case the 4-7-8 mode which promotes sleep
            func breatheIn() {
                withAnimation(.easeIn(duration: 4)) {
                    scale = 1.5
                }
            //MARK: We do not forget to put an animation condition to stop it when the button is clicked again, otherwise the animation does not stop completely.
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    if isAnimating {
                        holdBreath()
                    }
                }
            }

            func holdBreath() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                    if isAnimating {
                        breatheOut()
                    }
                }
            }

            func breatheOut() {
                withAnimation(.easeOut(duration: 8)) {
                    scale = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                    if isAnimating {
                        breatheIn()
                    }
                }
            }

        //MARK: This view allows the creation of the somewhat organic effect of the shape via the width and height range settings that can be assigned randomly. The colors for the gradient are to be defined in the assets with AccentColor and an additional color for example.
        @ViewBuilder
        func BlobedView() -> some View {
            Rectangle()
                .fill(.linearGradient(colors: [Color("AccentColor"), Color("Color")], startPoint: .top, endPoint: .bottom))
                .mask {
                    TimelineView(.animation(minimumInterval: 3.4, paused: false)) { _ in
                        Canvas { context, size in
                            context.addFilter(.alphaThreshold(min: 0.4, color: .white))
                            context.addFilter(.blur(radius: 70))
                            
                            context.drawLayer { ctx in
                                for index in 1...20 {
                                    if let resolvedView = context.resolveSymbol(id: index) {
                                        ctx.draw(resolvedView, at: CGPoint(x:size.width / 2, y: size.height / 2))
                                    }
                                }
                            }
                        } symbols: {
                            ForEach(1...20,id: \.self) { index in
                                let offset = (startAnimation ? CGSize(width: .random(in: -30...42), height: .random(in: -30...43)) : .zero)
                                RoundedF(offset: offset)
                            }
                        }
                    }
                }
                .contentShape(Rectangle())
        }
        
    //MARK:This view here proposes the creation of the original shape, it is therefore the one that will be created as a base and then added to BlobedView, to create this somewhat unpredictable effect of the shape when it grows and shrinks. I also added a haptic feedback which will emit more vibration when the form reaches a certain scale (so during inspiration) and emit a softer feedback when it is necessary to exhale in this case.
        
        @ViewBuilder
        func RoundedF(offset: CGSize) -> some View {
            RoundedRectangle(cornerRadius: 70, style: .continuous)
                .fill(.white)
                .frame(width: 160, height: 180)
                .offset(offset)
                .animation(.easeInOut(duration: 3), value: offset)
                .scaleEffect(scale)
                .onChange(of: scale) { newValue in
                    if newValue < 1.1 {
                        let impactLight = UIImpactFeedbackGenerator(style: .light)
                        impactLight.impactOccurred()
                    } else if newValue > 1.3 {
                        let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                        impactHeavy.impactOccurred()
                    }
                }
        }
        
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
