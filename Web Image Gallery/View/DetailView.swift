//
//  DetailView.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 23/06/2023.
//


//In this view, we configure the "detail" aspect once the user has clicked on the image that interests him so that he can have a complete view of it, like a lightbox gallery, without having the animation that we know from the traditional web.
import SwiftUI

struct DetailView: View {
    var row: Row
    var animationID: Namespace.ID
    //View Properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            AsyncImage(url: row.imageUrl)
                .matchedGeometryEffect(id: row.id.uuidString, in: animationID)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(contentMode: .fit)
                .padding(.top,10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea())
        .overlay(alignment: .topLeading) {
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8)) {
                    dismiss()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .padding(15)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CtView()
    }
}
