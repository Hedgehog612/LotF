//
//  GameUI.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
class GameUI {
    //------------------------------------------------------------------------------
    // pickPlayers
    // Sets the number of players and their names.
    //------------------------------------------------------------------------------
    func pickPlayers() -> [String] {
        let names = [
            "Albertus",
            "Bartholomew",
            "Candoodle",
            "Diddlywump",
            "Ethelred",
            "Fnordigan",
            "Gobblesmack",
            "Hootenbart"
        ]
        let numberOfPlayers = Int.random(in: 3...8)
        return Array(names.prefix(numberOfPlayers))
    }
}
