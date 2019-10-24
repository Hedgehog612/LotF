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
    var cards = [Card]()
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(cardCounts: [Card: Int] = [:]) {
        for (card, count) in cardCounts {
            for _ in 0..<count {
                cards.append(card)
            }
        }
    }
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init() {
    }
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(cards cardsIn: [Card]) {
        for card in cardsIn {
            cards.append(card)
        }
    }
    
    
    //------------------------------------------------------------------------------
    // cardCounts
    // Returns our contents as a dictionary of [Card : # of cards]
    // We return 0 for every possible Card if we don't contain any of them.
    //------------------------------------------------------------------------------
    var cardCounts: [Card: Int] {
        var result = [Card: Int]()
        for card in Card.allCases {
            result[card] = 0
        }
        
        for card in cards {
            result[card]! += 1
        }
        
        return result
    }
    
    
    //------------------------------------------------------------------------------
    // sortedCards
    // Returns all our cards, sorted (as usual, by score and then name)
    //------------------------------------------------------------------------------
    var sortedCards: [Card] {
        return cards.sorted()
    }
    
    
    //------------------------------------------------------------------------------
    // addCard
    // Adds a single card to this deck
    //------------------------------------------------------------------------------
    func addCard(_ card: Card) {
        cards.append(card)
    }
    
    
    //------------------------------------------------------------------------------
    // removeCard
    // Removes a single card from this deck
    //------------------------------------------------------------------------------
    func removeCard(_ card: Card) {
        guard let index = cards.firstIndex(of: card) else {
            assert(false)
        }
        
        cards.remove(at: index)
    }
    
    
    //------------------------------------------------------------------------------
    // deal
    // Deal a card to another player
    //------------------------------------------------------------------------------
    func deal(recipient: Deck) {
        let dealtCard = cards.remove(at: 0)
        recipient.cards.append(dealtCard)
    }
    
    
    //------------------------------------------------------------------------------
    // shuffleAndDeal
    // Shuffle this deck and deal all the cards in it to an array of target decks.
    //------------------------------------------------------------------------------
    func shuffleAndDeal(recipients: [Deck]) {
        // Create an array of individual cards and sort them by random number
        var individualCards = [(card: Card, order: Double)]()
        for card in cards {
            individualCards.append((card: card, order: Double.random(in: 0..<1)))
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
