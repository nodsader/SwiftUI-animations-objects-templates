//
//  ContentView.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 24/06/2023.
//

import SwiftUI

struct SliderView: View {
    private let color: Color =  Color(red: 152/255, green: 251/255, blue: 152/255)
    private let topColor = Color(red: 173/255, green: 216/255, blue: 230/255)
    private let bottomColor = Color(red: 230/255, green: 230/255, blue: 250/255)
    @State private var offset: CGFloat = 0
    var rectSize = CGSize(width: 300, height: 30)
    var circleSize: CGFloat = 50
    @GestureState var dragging: Bool = false
    @State var previousOffset: CGFloat = 0
    @State private var isBeating: Bool = false
    
    var body: some View {
        GeometryReader { bounds in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                               startPoint: .top,
                               endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    emotionSlider
                }
            }
        }
    }
    
    private var emotionSlider: some View {
        ZStack {
            Canvas { context, size in
                context.addFilter(.alphaThreshold(min: 0.5, max: 1, color: color))
                context.addFilter(.blur(radius: 10))
                
                context.drawLayer { ctx in
                    if let rectangle = ctx.resolveSymbol(id: "Rectangle") {
                        ctx.draw(rectangle, at: CGPoint(x: size.width/2, y: size.height/2))
                    }
                    if let circle = ctx.resolveSymbol(id: "Circle") {
                        ctx.draw(circle, at: CGPoint(x: size.width/2 - rectSize.width/2 + circleSize/2, y: size.height/2))
                    }
                }
            } symbols: {
               Rectangle()
                    .frame(width: rectSize.width, height: rectSize.height, alignment: .center)
                    .tag("Rectangle")
                
                Circle()
                    .fill(Color.black)
                    .frame(width: circleSize, height: circleSize, alignment: .center)
                    .offset(x: offset)
                    .animation(.spring(), value: dragging)
                    .tag("Circle")
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .updating($dragging, body: { _, state, _ in state = true
                    })
                    .onChanged({ value in
                        self.offset = min(max(self.previousOffset + value.translation.width, 0), rectSize.width - circleSize)
                    })
                    .onEnded({ value in
                        self.previousOffset = self.offset
                    })
            )
            Circle()
                .fill(Color(red: 173/255, green: 216/255, blue: 230/255))
                .frame(width: circleSize - 14)
                .overlay {
                    Text("\(image)")
                        .font(.system(size: 25))
                        .scaleEffect(dragging ? 1 : 0.8)
                        .scaleEffect(isBeating ? 0.8 : 1)
                }
                .offset(x: (-rectSize.width/2) + (circleSize/2))
                .offset(x: offset)
                .animation(animation, value: dragging)
                .allowsHitTesting(false)
        }
        .frame(height: 300)
    }
    
    private var animation: Animation {
        .spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)
    }
    
    private var image: Text {
        let percentage = Double(offset) / Double(rectSize.width - circleSize) * 100
        switch percentage {
        case 0..<25:
            return Text("😕")
        case 25..<50:
            return Text("😐")
        case 50..<75:
            return Text("😊")
        default:
            return Text("😄")
        }
    }
    
}


struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}
