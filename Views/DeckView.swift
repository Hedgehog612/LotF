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
// DeckView
// Displays the player's hand
//------------------------------------------------------------------------------
struct DeckView: View {
    let deck : Deck
    var placedCards = [PlacedCard]()
    
    
    //------------------------------------------------------------------------------
    // initializer
    // This does all the work of figuring out where all our views go. They'll get
    // created in body
    //------------------------------------------------------------------------------
    init(_ deckIn: Deck) {
        deck = deckIn
        
        // Create a stack of cards for each card type
        let typesToShow = deck.cards.filter({ $0.1 > 0})
        for (stackIndex, (card, count)) in typesToShow.enumerated() {
            // Coordinates are ugly. We build the stack upward from the top right, so we start out
            // at an offset determined by how many cards are in the stack and work backward.
            let stackX = 50 + 100 + 250 * stackIndex + (count - 1) * 5
            let stackY = 210 - (count - 1) * 5
            
            for cardIndex in 0..<count {
                placedCards.append(PlacedCard(card: card, x: CGFloat(stackX - cardIndex * 5), y: CGFloat(stackY + cardIndex * 5)))
            }
        }
    }
    
    
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        ZStack {
            ForEach(placedCards, id: \.self) { placedCard in
                CardView(card: placedCard.card)
                    .position(x: placedCard.x, y: placedCard.y)
            }
        }
        .frame(width: 1600, height: 360, alignment: .top)
        .background(Color.white)
    }
}


//------------------------------------------------------------------------------
// PlacedCard
// Ugly little placeholder for where we want to put a CardView
//------------------------------------------------------------------------------
struct PlacedCard: Hashable {
    var card: Card
    var x: CGFloat
    var y: CGFloat
}


