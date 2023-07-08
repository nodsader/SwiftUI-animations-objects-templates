//
//  CView.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 08/07/2023.
//

import SwiftUI

struct CView: View {
    var body: some View {
        NavigationStack {
            MainV()
                .navigationTitle("Slide")
        }
    }
}

struct CView_Previews: PreviewProvider {
    static var previews: some View {
        CView()
    }
}
