//
//  Game.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
class Game {
    var currentOrder: CurrentOrder?
    var specialRule: String
    var playerOrder: [Player]
    var nullPile: [Card]
    var stewPot: [Card]
    var timer: Int
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init(specialRule specialRuleIn: String, playerOrder playerOrderIn: [Player]) {
        specialRule = specialRuleIn
        playerOrder = playerOrderIn
        nullPile = []
        stewPot = []
        timer = 0
    }
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func fillOrder(player: Player) {
        print("Can you fill the order? The order is\(currentOrder!.name) and it contains \(currentOrder?.content). It has been short \(currentOrder?.short) times.")
    }
}
