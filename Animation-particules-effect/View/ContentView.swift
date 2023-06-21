//
//  ContentView.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 21/06/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            MainView()
                .navigationTitle("Particles Buttons")
        }
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
