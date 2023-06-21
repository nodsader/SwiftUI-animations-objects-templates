//
//  Particule.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 21/06/2023.
//

import SwiftUI

struct Particule: Identifiable {
    var id: UUID = .init()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1
    
    var opacity: CGFloat = 1
    
    
    
    
    mutating func reset() {
        randomX = 0
        randomY = 0
        scale = 1
        opacity = 1
    }
}
