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
    var hand: [Card : Int]
    var score: [Card : Int]
    var name: String
    var image: String
    var scoreTokens: Int
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init(name nameIn: String, image imageIn: String) {
        hand = [:]
        score = [:]
        name = nameIn
        image = imageIn
        scoreTokens = 0
    }
}



class Deck {
    var cardCounts = [Card : Int]()
    
    init() {
        for card in Card.allCases {
            cardCounts[card] = 0
        }
    }
}
