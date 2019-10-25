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
        if gameTester!.testedHands == false {
            gameTester!.testHandSize()
        }
        game.onPickRollThisOrder(false)
    }
    
    
    //------------------------------------------------------------------------------
    // pickOrder
    // Choose an item on the menu
    //------------------------------------------------------------------------------
    override func pickOrder() {
        game.onPickedOrder(MenuItem(name: "David Copperfield", ingredients:
        [.Cheese:1]))
    }
    
    
    //------------------------------------------------------------------------------
    //sendOrderToPlayer
    //Fill or pass based on what we need to test
    //------------------------------------------------------------------------------
    override func sendOrderToPlayer() {
        if gameTester!.testedPass == false {
            game.pickedFillOrder(true)
        } else {
            gameTester!.doTest(result: game.players[0].hand.cards.count > 10, comment: "Testing passing")
            gameTester!.doTest(result: game.players[(game.players.count - 1)].hand.cards.count < 11, comment: "Testing passing")
            game.endTheGame()
        }
    }
    
    
    //------------------------------------------------------------------------------
    //pickCardsToFill
    //Deliberately fail to fill the order
    //------------------------------------------------------------------------------
    override func pickCardsToFill() {
        let kludgeDeck = Deck(cardCounts: [.Short:1])
        game.fillTheOrder(cards: kludgeDeck.cards)
    }
    
    
    override func passTheOrder() {
        game.orderPassed(card: game.players[0].hand.cards[0])
    }
    
}
