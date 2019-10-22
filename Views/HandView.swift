//
//  DeckView.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import SwiftUI


//------------------------------------------------------------------------------
// HandView
// Displays the player's hand
//------------------------------------------------------------------------------
struct HandView: View {
    let deck: Deck
    
    
    //------------------------------------------------------------------------------
    // initializer
    //------------------------------------------------------------------------------
    init(deck deckIn: Deck) {
        deck = deckIn
    }
    
    
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        // Create a StackView for each type of card
        var stackViews = [StackView]()
        let typesToShow = deck.cards.filter({ $0.1 > 0}).sorted(by: { $0 < $1 })
        for (stackIndex, (card, count)) in typesToShow.enumerated() {
            let stackX = 20 + 130 + 260 * stackIndex    // 20 border + Stack width / 2 + Stack width * index
            var cards = [Card]()
            for _ in 0..<count {
                cards.append(card)
            }
            
            stackViews.append(StackView(cards: cards, x: CGFloat(stackX), y: CGFloat(180)))
        }

        return GeometryReader { geometry in
            ForEach(stackViews, id: \.self) { stackView in
                stackView.body
            }
        }
        .frame(width: 1600, height: 380, alignment: .top)
        .background(Color.white)
    }
}
