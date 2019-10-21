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
    
    //CurrentOrder fully initializes from a given menuItem and no other input
    init (originalOrder originalOrderIn: MenuItem) {
    
        originalOrder = originalOrderIn
        name = originalOrder.name
        tokens = 0
        short = 0
        content = []
        for card in originalOrder.ingredients.keys {
            for _ in 1...originalOrder.ingredients[card]! {
                content.append(card)
            }
        }
    }
    
    //Takes an array of cards and evaluates if it can fill the order.
    func orderMatch(submittedOrder: [Card]) -> Bool {
        //We need at least necessaryMatch cards to match for the order to be valid
        let neededMatches = content.count-short
        var totalMatched = 0
        for (index, card) in submittedOrder.enumerated() {
            if card.matchesRequirement(requirement: content[index]) {
                totalMatched += 1
            }
        }
        return totalMatched >= neededMatches
    }
}
