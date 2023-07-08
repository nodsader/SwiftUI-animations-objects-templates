//
//  Card.swift
//  animations-objects
//
//  Created by Mathieu Moutarde on 08/07/2023.
//

import SwiftUI

//MARK: CARD Model for the carrousel

struct Card: Identifiable, Hashable, Equatable {
    var id: UUID = .init()
    var image: String
    var previousOff: CGFloat = 0
}
