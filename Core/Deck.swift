//
//  Deck.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// Deck
// A set of cards. For convenience in using the deck, we store a count of each
// card type rather than an actual array of cards.
//------------------------------------------------------------------------------
class Deck {
    var cards: [Card : Int]     // How many cards of each type do we contain?
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(_ cardsIn: [Card: Int] = [:]) {
        cards = [:]
        
        // Set our count of all possible cards to zero
        for card in Card.allCases {
            cards[card] = 0
        }
        
        // Add any specified cards to the deck
        for (card, count) in cardsIn {
            cards[card] = count
        }
    }
    
    
    //------------------------------------------------------------------------------
    // addCard
    // Adds a single card to this deck
    //------------------------------------------------------------------------------
    func addCard(_ card: Card) {
        cards[card]! += 1
    }
    
    
    //------------------------------------------------------------------------------
    // removeCard
    // Removes a single card from this deck
    //------------------------------------------------------------------------------
    func removeCard(_ card: Card) {
        assert(cards[card]! > 0)
        cards[card]! -= 1
    }
    
    
    //------------------------------------------------------------------------------
    // aCard
    // Silly helper function that should go away soon. Returns some card that we
    // contain.
    //------------------------------------------------------------------------------
    func aCard() -> Card {
        for (card, count) in cards {
            if count > 0 {
                return card
            }
        }
        
        assert(false)
    }
    
    
    //------------------------------------------------------------------------------
    // shuffleAndDeal
    // Shuffle this deck and deal all the cards in it to an array of target decks.
    //------------------------------------------------------------------------------
    func shuffleAndDeal(recipients: [Deck]) {
        // Create an array of individual cards and sort them by random number
        var individualCards = [(card: Card, order: Double)]()
        for (card, count) in cards where count > 0 {
            for _ in 1...count {
                individualCards.append((card: card, order: Double.random(in: 0..<1)))
            }
        }
        var sortedCards = individualCards.sorted(by: { $0.order < $1.order })
        
        // Now deal them all out
        var nextRecipient = 0
        while sortedCards.count > 0 {
            recipients[nextRecipient].addCard(sortedCards[0].card)
            sortedCards.remove(at: 0)
            nextRecipient = nextRecipient < recipients.count - 1 ? nextRecipient + 1 : 0
        }
    }
}
