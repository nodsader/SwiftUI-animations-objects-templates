//
//  CtView.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 23/06/2023.
//

import SwiftUI

struct CtView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("My Work")
        }
    }
}
struct CtView_Previews: PreviewProvider {
    static var previews: some View {
        CtView()
    }
}
