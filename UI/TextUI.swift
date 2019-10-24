//
//  TextUI.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// TextUI
// Provides a command line interface to the game. FullUI subclasses this to provide
// a rich graphical UI.
//------------------------------------------------------------------------------
class TextUI {
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init() {
        beginExecutionQueue()
    }
    




    //==============================================================================
    // Game start
    //==============================================================================

    //------------------------------------------------------------------------------
    // pickPlayers
    // Sets the number of players and their names.
    //------------------------------------------------------------------------------
    func pickPlayers() {
        print("\n\nWelcome to Lord of the Fries!")
        print("How many players would you like (3 - 8)?")
        
        // How many players?
        var numberOfPlayers: Int?
        while numberOfPlayers == nil {
            var answer: String?
            while answer == nil {
                answer = readLine()
            }
            numberOfPlayers = Int(answer!)
        }
        
        // Now get their names
        var names = [String]()
        while names.count < numberOfPlayers! {
            print("What is player \(names.count + 1) called?")
            var answer: String?
            while answer == nil {
                answer = readLine()
            }
            names.append(answer!)
        }
        
        addToQueue {
            game.onPlayersSelected(names: names)
        }
    }


    //------------------------------------------------------------------------------
    // pickNumberOfRounds
    // How many rounds are we gonna play?
    //------------------------------------------------------------------------------
    func pickNumberOfRounds() {
        print("\n\nHow many rounds will you play?")

        var numberOfRounds: Int?
        while numberOfRounds == nil || numberOfRounds! <= 0 {
            var answer: String?
            while answer == nil {
                answer = readLine()
            }
            numberOfRounds = Int(answer!)
        }
        
        addToQueue {
            game.onNumberOfRoundsPicked(numberOfRounds!)
        }
    }
    
    



    //==============================================================================
    // Main game loop
    //==============================================================================

    //------------------------------------------------------------------------------
    // startMainUI
    // Bring up the UI for the main gameplay loop.
    //------------------------------------------------------------------------------
    func startMainUI() {
        print("\n\n\nStarting the main game UI")
        print("\(game.numberOfRounds) rounds.")
        print("Players:")
        for player in game.players {
            print("   \(player.name)")
        }
    }


    //------------------------------------------------------------------------------
    // pickRestaurant
    // Which restaurant do we want for this shift?
    //------------------------------------------------------------------------------
    func pickRestaurant() {
        let textMenu = TextMenu(prompt: """
            Starting round \(game.currentRound).
            Which restaurant would you like?
        """)
        
        for restaurant in restaurantList {
            textMenu.addChoice(restaurant.name, onSelect: { game.onRestaurantSelected(restaurant) })
        }
        
        textMenu.execute()
    }
    
    
    //------------------------------------------------------------------------------
    // pickRollThisOrder
    // Do we want to roll this order? (Otherwise, choose it ourselves)
    //------------------------------------------------------------------------------
    func pickRollThisOrder() {
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
    func pickOrder() {
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
    
    
    //------------------------------------------------------------------------------
    // displayRolledOrder
    // We've rolled an order: tell the user what it is
    //------------------------------------------------------------------------------
    func displayRolledOrder(_ currentOrder: CurrentOrder) {
        print("You rolled: \(currentOrder.originalItem.name)")
        addToQueue {
            game.doneWithOrderPicking()
        }
    }
    
    
    //------------------------------------------------------------------------------
    //
    //------------------------------------------------------------------------------
    func sendOrderToPlayer() {
        let textMenu = TextMenu(prompt: """
            \(game.players[0].name), it's your turn.
            The order is\(game.currentOrder.originalItem.name).
            It has been short \(game.currentOrder.short) times.
            Would you like to fill this order?
            """
        )
        
        textMenu.addChoice("Fill the order", onSelect: { game.pickedFillOrder(true) })
        textMenu.addChoice("Pass", onSelect: { game.pickedFillOrder(false) })
        
        textMenu.execute()
    }
    
    
    //------------------------------------------------------------------------------
    // pickCardsToFill
    // Fill an order with cards from your hand
    //------------------------------------------------------------------------------
    func pickCardsToFill() {
        let textMenu = TextMenu(prompt: """
            The order is\(game.currentOrder.originalItem.name).
            It has been short \(game.currentOrder.short) times.
        """)
        
        textMenu.addChoice("Huh", onSelect: { game.fillTheOrder(cards: [Card]() )})
        
        textMenu.execute()
    }
    
    
    //------------------------------------------------------------------------------
    // passTheOrder
    // The current player is passing on the order. They need to pick a card to pass
    // to the player on their left (if the order was called) or the shift leader (if
    // the order was rolled).
    //------------------------------------------------------------------------------
    func passTheOrder(recipient: Player) {
        let textMenu = TextMenu(prompt: """
            Because you're passing, you need to pass one card to \(recipient.name).
            Which card would you like to pass?
        """)
        
        for card in game.players[0].hand.cards {
            textMenu.addChoice(card.name, onSelect: { game.passTheOrder(card: card) })
        }
        
        textMenu.execute()
    }
    
    
    //------------------------------------------------------------------------------
    // pickThreeCards
    // Special function for the Holiday Potluck: choose three ingredients.
    //------------------------------------------------------------------------------
    var threeCards = [Card]()
    func pickThreeCards() {
        threeCards = []
        pickThreeCardsHelper()
    }
    
    func pickThreeCardsHelper() {
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
