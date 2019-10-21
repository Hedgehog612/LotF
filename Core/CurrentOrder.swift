//
//  CurrentOrder.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
struct CurrentOrder {
    var content: [Card]
    var short: Int
    var tokens: Int
    var name: String
    var originalOrder: MenuItem
    
    init (originalOrder originalOrderIn: MenuItem) {
    
        originalOrder = originalOrderIn
        name = originalOrder.name
        tokens = 0
        short = 0
        content = []
        for card in originalOrder.ingredients.keys {
            for count in 1...originalOrder.ingredients[card]! {
                content.append(card)
            }
        }
    }
}
