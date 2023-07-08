//
//  OffsetReader.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 08/07/2023.
//

import SwiftUI

struct offsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping(CGFloat) -> ()) -> some View {
        self
            .overlay{
                GeometryReader {
                    let minX = $0.frame(in: .named("scrollView")).minX
                    Color.clear
                        .preference(key: offsetKey.self, value: minX)
                        .onPreferenceChange(offsetKey.self, perform: { value in
                            completion(value)
                        })
                }
            }
    }
}
                                        
extension [Card] {
 func indOf(_ card: Card) -> Int {
 return self.firstIndex(of:card) ?? 0
   }
}
