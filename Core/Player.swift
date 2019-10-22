//
//  Player.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
class Player {
    var hand: Deck
    var score: Deck
    var name: String
    var image: String
    var scoreTokens: Int
    var totalScore: Int
    var tempScore: Int
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    //Score tracks the player's score in a given round as a dictionary of cards. TotalScore tracks the player's total score across all rounds played, and can be stored as an int.
    init(name nameIn: String, image imageIn: String, totalScore totalScoreIn: Int = 0) {
        hand = Deck()
        score = Deck()
        name = nameIn
        image = imageIn
        scoreTokens = 0
        totalScore = totalScoreIn
        tempScore = 0
    }
    
    //The player filled an order and moves cards from hand into score
    //We assume the order had no tokens, but if it did they are moved as well
    //This takes the array of cards the player played, not the array of cards the order required, because the order could be short or substituted.
    func filledOrder(orderCards: [Card], tokens: Int = 0) {
        for card in orderCards {
            hand.removeCard(card)
            score.addCard(card)
        }
        scoreTokens += tokens
    }
}
