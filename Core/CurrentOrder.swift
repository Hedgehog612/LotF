//
//  CurrentOrder.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// CurrentOrder
// Once the shift leader picks a menu item, it becomes a CurrentOrder. This tracks
// what the customer ordered, whether it's short, etc.
//------------------------------------------------------------------------------
struct CurrentOrder {
    var originalItem: MenuItem
    var short: Int
    var tokens: Int
    var timesPassed: Int
    var content = [Card]()
    

    //------------------------------------------------------------------------------
    // init
    // Builds us based on a given menuItem
    //------------------------------------------------------------------------------
    init (originalOrder originalOrderIn: MenuItem) {
        //timesPassed is related to short: If timesPassed == playerOrder.count, timesPassed = 0 and short += 1.
        //If short == content.count, terminate the order and move on.
        originalItem = originalOrderIn
        tokens = 0
        short = 0
        timesPassed = 0

        for card in originalItem.ingredients.keys {
            for _ in 1...originalItem.ingredients[card]! {
                content.append(card)
            }
        }
    }
    
    
    //------------------------------------------------------------------------------
    // doesOrderMatch
    // Can a given array of cards fill this order?
    //------------------------------------------------------------------------------
    func doesOrderMatch(submittedOrder: [Card]) -> Bool {
        //We need at least necessaryMatch cards to match for the order to be valid
        let neededMatches = content.count - short
        var totalMatched = 0
        for (index, card) in submittedOrder.enumerated() {
            if card.matchesRequirement(requirement: content[index]) {
                totalMatched += 1
            } else if game.restaurant!.name == "Montezuma's Mexi-Deli" && card.isMeat() && content[index].isMeat() {
                totalMatched += 1
            }
        }
        return totalMatched >= neededMatches
    }
    
    
    //------------------------------------------------------------------------------
    // montezumaMatch
    // For Montezuma's restaurant: Replace any meat matches with 0-point AnyMeat cards.
    //------------------------------------------------------------------------------
    func montezumaMatch(playerCards: [Card]) -> [Card] {
        var newOrder = playerCards
        for (index, card) in newOrder.enumerated() {
            if !card.matchesRequirement(requirement: content[index]) && card.isMeat() && content[index].isMeat() {
                newOrder[index] = .AnyMeat
            }
        }
        return newOrder
    }
}
