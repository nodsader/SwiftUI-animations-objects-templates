//
//  MainV.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 08/07/2023.
//

import SwiftUI

struct MainV: View {
    @State var cards: [Card] = [
        //MARK: name of your image right here :
        .init(image: "image-1"),
        .init(image: "image-2"),
        .init(image: "image-3"),
        .init(image: "image-4"),
        .init(image: "image-5"),
        .init(image: "image-6"),
        .init(image: "image-7"),
    ]
    var body: some View {
        VStack {
            //MARK: we use the geometry reader so that no image is excluded from supporting the extension of the image size when we slide to it.
            GeometryReader {
                let size = $0.size
                ScrollView(.horizontal) {
                    HStack(spacing: 8){
                        ForEach(cards) { card in
                            CardStyle(card)
                        }
                    }
                    .padding(.trailing, size.width - 200)
                }
                .coordinateSpace(name: "scrollView")
                .scrollIndicators(.hidden)
                .clipShape(Rectangle())
                .cornerRadius(25)
            }
            .padding(.horizontal, 15)
            .padding(.top, 200)
            .frame(height: 200)
            Spacer(minLength: 0)
        }
    }
    
    //MARK: The builder who will manage the display of images in the carousel, it is through his intervention that we can correctly size each slide present. We use the offsetReader (in Model) to better control the display and the offset of each image by determining a CGFLOAT and the possibility of detecting the size variations of the other images of the slide. This creates something that is fluid and fits well on the screen.
    
    @ViewBuilder
    func CardStyle(_ card: Card) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minX = proxy.frame(in: .named("scrollView")).minX
            let reducWidth = (minX / 208) * 120
            let capWidth = min(reducWidth, 120)
            
            let frameWidth = size.width - ( minX > 0 ? capWidth : -capWidth)
            
            Image(card.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .frame(width: frameWidth)
                .clipShape(Rectangle())
                .cornerRadius(25)
                .offset(x: minX > 0 ? 0 : -capWidth)
                .offset(x: -card.previousOff)
        }
        .frame(width: 200, height: 200)
        .offsetX { offset in
            let reducWidth = (offset / 208) * 120
            let index = cards.indOf(card)
            
            if cards.indices.contains(index + 1) {
                cards[index + 1].previousOff = (offset < 0 ? 0 : reducWidth)
            }
        }
    }
}

struct MainV_Previews: PreviewProvider {
    static var previews: some View {
       CView()
    }
}
