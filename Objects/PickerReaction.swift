//
//  PickerReaction.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 21/06/2023.
//

import SwiftUI

struct PickerReaction: View {
    enum Reaction: Identifiable, CaseIterable {
        case like, dislike, smile, love
        var id: Self {self}
    }
    
    @State var select: Reaction? = .none
    
    var body: some View {
        Menu("Reactions") {
            Picker("Palette", selection: $select) {
                Label("Like", systemImage: "hand.thumbsup").tag(Reaction.like)
                Label("Dislike", systemImage: "hand.thumbsdown").tag(Reaction.dislike)
                Label("Smile", systemImage: "face.smiling").tag(Reaction.smile)
                Label("Love", systemImage: "heart").tag(Reaction.love)
            }
            .pickerStyle(.automatic)
            Button("Reply...") {}
        }
    }
}

struct PickerReaction_Previews: PreviewProvider {
    static var previews: some View {
        PickerReaction()
    }
}
