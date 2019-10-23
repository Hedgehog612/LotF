//
//  Player.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// Player
// A single player in the game.
//------------------------------------------------------------------------------
class Player {
    var name: String            // Who are we?
    var image: String
    var hand: Deck              // Our hand: the cards we are able to play
    var score: Deck             // Our score pile: all the cards we've played when filling orders
    var scoreTokens: Int
    var totalScore: Int
    var tempScore: Int
    

    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(name nameIn: String, image imageIn: String, totalScore totalScoreIn: Int = 0) {
        hand = Deck()
        score = Deck()
        name = nameIn
        image = imageIn
        scoreTokens = 0
        totalScore = totalScoreIn
        tempScore = 0
    }

    
    //------------------------------------------------------------------------------
    // filledOrder
    // The player filled an order so we need to move the relevant cards from hand into score
    // We also move any relevant tokens into our stash.
    // This takes the array of cards the player played, not the array of cards the order required,
    // because the order could be short or substituted.
    //------------------------------------------------------------------------------
    func filledOrder(orderCards: [Card], tokens: Int = 0) {
        for card in orderCards {
            if card == .AnyMeat {
                hand.removeCard(card)
                game.nullPile.addCard(card)
            } else if card == .Short {
                
            } else {
                hand.removeCard(card)
                score.addCard(card)
            }
        }
        scoreTokens += tokens
    }
}
