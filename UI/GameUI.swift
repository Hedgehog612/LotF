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
    func pickPlayers() {
        DispatchQueue.main.async {
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

            game.onPlayersSelected(names: Array(names.prefix(numberOfPlayers)))
        }
    }
    

    //------------------------------------------------------------------------------
    // pickRestaurant
    // Which restaurant do we want for this shift?
    //------------------------------------------------------------------------------
    func pickRestaurant() {
        DispatchQueue.main.async {
            game.onRestaurantSelected(restaurantList[0])
        }
    }

    
    //------------------------------------------------------------------------------
    // pickNumberOfRounds
    // How many rounds are we gonna play?
    //------------------------------------------------------------------------------
    func pickNumberOfRounds() {
        DispatchQueue.main.async {
            game.onNumberOfRoundsPicked(4)
        }
    }
    
    
    //------------------------------------------------------------------------------
    // rollThisOrder
    // Do we want to roll to pick this order? (Otherwise, pick it)
    //------------------------------------------------------------------------------
    func rollThisOrder() -> Bool {
        return false
    }


    //------------------------------------------------------------------------------
    // pickOrder
    // Choose an item on the menu
    //------------------------------------------------------------------------------
    func pickOrder(restaurant: Restaurant) -> MenuItem {
        return restaurant.menuCategories[0].menuItems[0]
    }
    
    
    //------------------------------------------------------------------------------
    // pickFillOrPass
    // Choose whether to fill or pass (Always passes)
    //------------------------------------------------------------------------------
    func pickFillOrPass() -> Bool {
        return false
    }

    
    //------------------------------------------------------------------------------
    // pickCardsToFill
    // Fill an order with cards from your hand
    //------------------------------------------------------------------------------
    func pickCardsToFill() -> [Card] {
        return []
    }
}
