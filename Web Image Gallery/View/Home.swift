//
//  Home.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 23/06/2023.
//In this view we configure the display of the global gallery using the asynch method configured in the ImageLoader model which manages the error possibly in the loading of the image by a URL.

import SwiftUI

struct Home: View {
    //View Properties
    @State private var selectedRow: Row? = nil
    @Namespace private var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 5), count: 3), spacing: 10) {
                ForEach(rows) { row in
                    AsyncImage(url: row.imageUrl)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipped()
                        .padding(10)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.8, blendDuration: 0.8)) {
                                selectedRow = row
                            }
                        }
                }
            }
        }
        .fullScreenCover(item: $selectedRow) { row in
            DetailView(row: row, animationID: animation)
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        CtView()
    }
}
