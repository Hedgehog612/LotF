//
//  TestUI.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/24/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation

class TestUI: TextUI {
    var forcePlayerNames: [String]?
    var forceRestaurantChoice: Int?
    
    
    //------------------------------------------------------------------------------
    // pickPlayers
    // Contains default name array to run without user input. If input is provided, will not print confirmation text.
    //------------------------------------------------------------------------------
    override func pickPlayers() {
        var names: [String]
        if forcePlayerNames != nil {
            names = forcePlayerNames!
        } else {
            names = ["Adam", "Brian", "Chuck", "Donna"]
        }
        addToQueue {
            game.onPlayersSelected(names: names)
        }
    }
    
    //------------------------------------------------------------------------------
    // pickNumberOfRounds
    // Locked in to four rounds. May want to test longer or shorter games later.
    //------------------------------------------------------------------------------
    override func pickNumberOfRounds() {
        addToQueue {
            game.onNumberOfRoundsPicked(4)
        }
    }
    
    //------------------------------------------------------------------------------
    // startMainUI
    // Don't print anything here
    //------------------------------------------------------------------------------
    override func startMainUI() {
        
    }


    //------------------------------------------------------------------------------
    // pickRestaurant
    // Default to Friedey's to test some special orders but can be set to something else
    //------------------------------------------------------------------------------
    override func pickRestaurant() {
        if forceRestaurantChoice != nil {
            game.onRestaurantSelected(restaurantList[forceRestaurantChoice!])
        } else {
            game.onRestaurantSelected(restaurantList[1])
        }
    }
    
    //------------------------------------------------------------------------------
    // pickRollThisOrder
    // Do we want to roll this order? (Otherwise, choose it ourselves)
    //------------------------------------------------------------------------------
    override func pickRollThisOrder() {
        let textMenu = TextMenu(prompt: """
        \(game.shiftLeader.name), you are the shift leader.
        Would you like to pick an order or roll randomly?
        """)
        
        textMenu.addChoice("Pick an order", onSelect: { game.onPickRollThisOrder(false) })
        textMenu.addChoice("Roll this order randomly", onSelect: { game.onPickRollThisOrder(true)})
        
        textMenu.execute()
    }
    
    
    //------------------------------------------------------------------------------
    // pickOrder
    // Choose an item on the menu
    //------------------------------------------------------------------------------
    override func pickOrder() {
        let textMenu = TextMenu(prompt: """
        Here's the menu for \(game.restaurant.name):
        What's the next order?
        """)

        for menuCategory in game.restaurant.menuCategories {
            if menuCategory.canCall {
                textMenu.addDivider(menuCategory.name)
                
                for menuItem in menuCategory.menuItems {
                    textMenu.addChoice(menuItem.name, onSelect: { game.onPickedOrder(menuItem)})
                }
            }
        }
        
        textMenu.execute()
    }
    
    
/*
    //------------------------------------------------------------------------------
    // pickFillOrPass
    // Choose whether to fill or pass (Always passes)
    //------------------------------------------------------------------------------
    override func pickFillOrPass() -> Bool {
        return false
    }
    
    
    //------------------------------------------------------------------------------
    // pickCardsToFill
    // Fill an order with cards from your hand
    //------------------------------------------------------------------------------
    override func pickCardsToFill() -> [Card] {
        return []
    }
    
    
    //------------------------------------------------------------------------------
    // pickCardToDeal
    // Placeholder function to choose which card to deal from hand when you pass
    // Returns the index of the chosen card
    //------------------------------------------------------------------------------
    override func pickCardToDeal(hand: Deck) -> Int {
        return 0
    }
    
    
    //------------------------------------------------------------------------------
    // pickCardsToFill
    // Placeholder function to pick three cards for the Holiday Potluck and return an array of those three cards
    //------------------------------------------------------------------------------
    override func pickThreeCards() -> [Card] {
        return [.Bird, .Cheese, .Cow]
    }
 */
}
