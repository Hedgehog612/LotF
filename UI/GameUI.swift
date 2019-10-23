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
    //==============================================================================
    // Class factory
    //==============================================================================

    //------------------------------------------------------------------------------
    // UIType
    // What kind of UI do we want today?
    //------------------------------------------------------------------------------
    enum UIType {
        case automated          // Fully automated. The default, provided by this class
        case text               // Command-line UI, provided by the TextUI subclass
        case full               // Full graphical UI, provided by the FullUI subclass
    }
    
    
    //------------------------------------------------------------------------------
    // makeUI
    // Factory for producing a GameUI instance.
    //------------------------------------------------------------------------------
    class func makeUI(_ type: UIType) -> GameUI {
        var newInstance: GameUI!
        
        switch type {
        case .automated:
            newInstance = GameUI()
            newInstance.beginExecutionQueue()
    
        case .text:
            newInstance = TextUI()
            newInstance.beginExecutionQueue()
            
        case .full:
            newInstance = FullUI()
        }
        
        return newInstance
    }
    
    
    
    
    //==============================================================================
    // Core functionality
    //==============================================================================

    //------------------------------------------------------------------------------
    // pickPlayers
    // Sets the number of players and their names.
    //------------------------------------------------------------------------------
    func pickPlayers() {
        addToQueue {
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
        addToQueue {
            game.onRestaurantSelected(restaurantList[0])
        }
    }

    
    //------------------------------------------------------------------------------
    // pickNumberOfRounds
    // How many rounds are we gonna play?
    //------------------------------------------------------------------------------
    func pickNumberOfRounds() {
        addToQueue {
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
    
    
    //------------------------------------------------------------------------------
    // pickCardToDeal
    // Placeholder function to choose which card to deal from hand when you pass
    // Returns the index of the chosen card
    //------------------------------------------------------------------------------
    func pickCardToDeal(hand: Deck) -> Int {
        return 0
    }
    
    
    //------------------------------------------------------------------------------
    // pickCardsToFill
    // Placeholder function to pick three cards for the Holiday Potluck and return an array of those three cards
    //------------------------------------------------------------------------------
    func pickThreeCards() -> [Card] {
        return [.Bird, .Cheese, .Cow]
    }

    
    
    
    
    //==============================================================================
    // Concurrency support
    // We have an awkward concurrency issue: sometimes we run a SwifUI interface
    // (which is asynchronous and message-based) and sometimes we run a command
    // line or automated interface (which is synchronous). To allow us to have a single
    // coherent interface to both, we impose a simple message-passing architecture
    // on top of the automated and text versions.
    //
    // The basic idea is that every time you are making a call that would be initiated
    // by a message in SwiftUI, you should add that call to our execution queue.
    //==============================================================================
    var executionQueue = [(() -> ())]()
    
    
    //------------------------------------------------------------------------------
    // beginExecutionQueue
    // Fires up our message-passing system.
    //------------------------------------------------------------------------------
    func beginExecutionQueue() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { timer in self.executeQueue() })
    }


    //------------------------------------------------------------------------------
    // executeQueue
    // Called repeatedly by a timer, this checks our execution queue and if there's
    // anything in it, executes the next item.
    //------------------------------------------------------------------------------
    func executeQueue() {
        if executionQueue.count > 0 {
            let task = executionQueue.removeFirst()
            task()
        }
    }

    
    //------------------------------------------------------------------------------
    // addToQueue
    // Adds a task to the execution queue.
    //------------------------------------------------------------------------------
    func addToQueue(_ task: @escaping () -> ()) {
        executionQueue.append(task)
    }
}
