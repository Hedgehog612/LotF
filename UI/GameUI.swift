//
//  GameUI.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// GameUI
// This is our master UI class, which handles all user interactions. We subclass
// it to provide a fully automated UI which can play the game without human interaction,
// a command line UI, and a full graphical UI.
//------------------------------------------------------------------------------
class GameUI {
    //------------------------------------------------------------------------------
    // UIType
    // What kind of UI do we want today?
    //------------------------------------------------------------------------------
    enum UIType {
        case automated          // Fully automated. The default, provided by this class
        case text               // Command-line UI, provided by the TextUI subclass
        case full           // Full graphical UI, provided by the FullUI subclass
    }
    
    
    //------------------------------------------------------------------------------
    // makeUI
    // Factory for producing a GameUI instance.
    //------------------------------------------------------------------------------
    class func makeUI(_ type: UIType) -> GameUI {
        switch type {
        case .automated:
            return GameUI()
    
        case .text:
            return TextUI()
            
        case .full:
            return FullUI()
        }
    }
    
    
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
    

    //------------------------------------------------------------------------------
    // pickRestaurant
    // Which restaurant do we want for this shift?
    //------------------------------------------------------------------------------
    func pickRestaurant() -> Restaurant {
        return restaurantList[0]
    }
    
    func pickNumberOfRounds() -> Int {
        return 4
    }
}
