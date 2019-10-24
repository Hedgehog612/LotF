//
//  Game.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// Game
// This is a giant monster class that runs our core gameplay.
//------------------------------------------------------------------------------
class Game {
    //==============================================================================
    // Core functionality
    //==============================================================================
    var ui: TextUI
    var players: [Player]
    var nullPile: Deck
    var stewPot: Deck
    var timer: Int
    var deck: Deck

    // Curent round
    var numberOfRounds = 0
    var currentRound = 0
    var roundEnd = false
    var restaurant: Restaurant!
    var specialRule: String

    // Current shift
    var shiftLeader: Player!
    var currentOrder: CurrentOrder!
    var rolledOrder: Bool


    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(ui uiIn: TextUI) {
        ui = uiIn
        specialRule = ""
        players = []
        nullPile = Deck()
        stewPot = Deck()
        timer = 0
        rolledOrder = false
        deck = Deck()
    }
    
    
    
    
    
    //==============================================================================
    // Game startup
    //==============================================================================
    //------------------------------------------------------------------------------
    // beginGame
    // Start running the game.
    //------------------------------------------------------------------------------
    func beginGame() {
        ui.pickPlayers()
    }
    
    
    //------------------------------------------------------------------------------
    // onPlayersSelected
    // Called when the UI has picked the players.
    //------------------------------------------------------------------------------
    func onPlayersSelected(names: [String]) {
        for name in names {
            players.append(Player(name: name, image: "No image yet"))
        }
        ui.pickNumberOfRounds()
    }
    
    
    //------------------------------------------------------------------------------
    // onNumberOfRoundsPicked
    //------------------------------------------------------------------------------
    func onNumberOfRoundsPicked(_ numberOfRoundsIn: Int) {
        numberOfRounds = numberOfRoundsIn
        startGame()
    }
    
    
    
    
    
    //==============================================================================
    // Core game loop
    //==============================================================================
    
    //------------------------------------------------------------------------------
    // startGame
    // We've chosen players, etc. Now it's time to fire up the game.
    //------------------------------------------------------------------------------
    func startGame() {
        ui.startMainUI()
        startRound(round: 1)
    }
    
    
    //------------------------------------------------------------------------------
    // startRound
    // Begin a new round.
    //------------------------------------------------------------------------------
    func startRound(round: Int) {
        currentRound = round
        roundEnd = false
        ui.pickRestaurant()
    }
    

    //------------------------------------------------------------------------------
    // onRestaurantSelected
    // TODO: Restaurant selection should happen at the beginning of each round.
    //------------------------------------------------------------------------------
    func onRestaurantSelected(_ restaurantIn: Restaurant) {
        restaurant = restaurantIn

        // Set up the restaurant
        specialRule = restaurant!.specialRule
        if players.count <= 5 {
            deck = restaurant!.smallDeck
        } else {
            deck = restaurant!.largeDeck
        }
        if restaurant!.name == "McPubihan's" {
            for _ in 1...6 {
                deck.deal(recipient: stewPot)
            }
        }
        
        //Deals cards now we know what the deck should be
        while deck.cards.count > 0 {
            for player in players {
                if deck.cards.count > 0 {
                    deck.deal(recipient: player.hand)
                }
            }
        }
        
        startNewShift()
    }
    
    
    //------------------------------------------------------------------------------
    // startNewShift
    // Begin a new shift
    //------------------------------------------------------------------------------
    func startNewShift() {
        shiftLeader = players[0]
        ui.pickRollThisOrder()
    }
    
    
    //------------------------------------------------------------------------------
    // onPickRollThisOrder
    // The shift leader has decided whether to roll or pick.
    //------------------------------------------------------------------------------
    func onPickRollThisOrder(_ roll: Bool) {
        rolledOrder = roll
        
        if roll {
            // TODO: add dice to current order, display to user
            let greenDie = Int.random(in: 1..<6)
            let category = restaurant.menuCategories.first(where: { $0.range.contains(greenDie) })!
            
            let blackDie = Int.random(in: 1..<6)
            let menuItem = category.menuItems[blackDie - 1]
            
            currentOrder = CurrentOrder(originalOrder: menuItem)
            
            //Special order rules go here
            if category.name == "Special Orders" {
                currentOrder = specialOrder(oldOrder: currentOrder)
            }
            /*
             TODO: need to fix Donner Pass
            //Donner pass ends your turn
            if currentOrder!.originalItem.name == "Donner Pass" {
                currentOrder = nil
                let activePlayer = players.remove(at: 0)
                players.append(activePlayer)
                return
            }
            */
            
            ui.displayRolledOrder(currentOrder)
        } else {
            ui.pickOrder()
        }
    }
    
    
    //------------------------------------------------------------------------------
    // onPickOrder
    // We've picked an order for this shift.
    //------------------------------------------------------------------------------
    func onPickedOrder(_ menuItem: MenuItem) {
        currentOrder = CurrentOrder(originalOrder: menuItem)
        doneWithOrderPicking()
    }
    
    
    //------------------------------------------------------------------------------
    // doneWithOrderPicking
    // The order has been picked or rolled and we're ready to start cookin'
    //------------------------------------------------------------------------------
    func doneWithOrderPicking() {
        mainLoop()
    }
    
    
    //------------------------------------------------------------------------------
    // mainLoop
    // This is the main gameplay loop. It keeps cycling around the table trying to
    // fill the current order, checking for various end conditions along the way.
    //------------------------------------------------------------------------------
    func mainLoop() {
        // Is this round over?
        if roundEnd {
            endRound()
        }
        
        // Cycle to the next player and try to fill the order
        let prevPlayer = players.remove(at: 0)
        players.append(prevPlayer)
        ui.sendOrderToPlayer()
    }
    
    
    //------------------------------------------------------------------------------
    // pickedFillOrder
    // The current player has decided whether or not to fill the order.
    //------------------------------------------------------------------------------
    func pickedFillOrder(_ fillOrder: Bool) {
        if fillOrder {
            ui.pickCardsToFill()
        } else {
            // TODO: pick the correct player
            ui.passTheOrder(recipient: players[0])
        }
    }
    
    
    //------------------------------------------------------------------------------
    // fillTheOrder
    // Verify that the submitted cards can fill the provided order
    //------------------------------------------------------------------------------
    func fillTheOrder(playerCards: [Card]) {
        if currentOrder.doesOrderMatch(submittedOrder: playerCards) {
            orderFilled(fillCards: playerCards)
        } else {
            // TODO: pick the correct player
            // TODO: should try again
            ui.passTheOrder(recipient: players[0])
        }
    }
    
    
    //------------------------------------------------------------------------------
    // orderPassed
    // Move a card from the player's hand to the appropriate recipient
    // Move the player to the end of the order
    //------------------------------------------------------------------------------
    func passTheOrder(card: Card) {
        currentOrder.timesPassed += 1
        if currentOrder.timesPassed == players.count {
            currentOrder.timesPassed = 0
            currentOrder.short += 1
        }
        players[0].hand.removeCard(card)
        if rolledOrder {
            shiftLeader.hand.cards.append(card)
        } else {
            players[1].hand.cards.append(card)
        }
        let passedPlayer = players.remove(at: 0)
        players.append(passedPlayer)
        if passedPlayer.hand.cards.count == 0 {
            endRound()
        }
        if currentOrder.short == currentOrder.content.count {
            ui.pickRollThisOrder()
        } else {
            ui.sendOrderToPlayer()
        }
    }
    
    
    //------------------------------------------------------------------------------
    // orderFilled
    // Remove cards from hand
    // Move cards from hand into scoring
    //------------------------------------------------------------------------------
    func orderFilled(fillCards: [Card]) {
        for card in fillCards {
            players[0].hand.removeCard(card)
            players[0].score.cards.append(card)
        }
        players[0].scoreTokens += currentOrder.tokens
        if players[0].hand.cards.count == 0 {
            endRound()
        }
        ui.pickRollThisOrder()
    }
    
    
    //------------------------------------------------------------------------------
    // endRound
    //------------------------------------------------------------------------------
    func endRound() {
        scoring()
        if currentRound == numberOfRounds {
            endTheGame()
        }
        currentRound += 1
        startRound(round: currentRound)
    }
    
    
    //------------------------------------------------------------------------------
    // scoring
    //This function totals up everyone's score
    //------------------------------------------------------------------------------
    func scoring() {
        var roundScores = [Int]()
        for player in players {
            var roundPoints = 0
            for card in player.score.cards {
                //Score by multiplying the number of cards of each type by the point value of those cards
                roundPoints += card.score
            }
            roundPoints += player.scoreTokens
            //print("\(player.name) scored \(roundPoints) this round.")
            var lostPoints = 0
            for card in player.hand.cards {
                lostPoints += card.score
            }
            //print("\(player.name) has \(lostPoints) points still in hand.")
            roundPoints -= lostPoints
            player.tempScore = roundPoints
            roundScores.append(player.tempScore)
            //print("\(player.name)'s score this round is \(roundPoints)")
            player.totalScore += roundPoints
            //print("This brings \(player.name)'s total score to \(player.totalScore).")
        }
        //Move the player with the smallest score to the front
        let minScore = roundScores.min()!
        var movePlayer: Player
        for _ in 1...players.count {
            if players[0].tempScore > minScore {
                movePlayer = players.remove(at: 0)
                players.append(movePlayer)
            }
        }
        //Reset tempScore, scoreTokens for next round
        for player in players {
            player.tempScore = 0
            player.scoreTokens = 0
        }
    }
    
    
    //------------------------------------------------------------------------------
    // endTheGame
    //------------------------------------------------------------------------------
    func endTheGame() {
        
    }

    
    
    //This function handles special orders
    func specialOrder(oldOrder: CurrentOrder!) -> CurrentOrder {
        var newOrder = oldOrder
        var secondOrder: CurrentOrder
        let orderType = Int.random(in: 0..<5)
        let orderNumber = Int.random(in: 0..<5)
        switch oldOrder.originalItem.name {
        case "Add one Bun",
             "Add one Cheese",
             "Add one Meat",
             "Add one Drink",
             "Add one Fish":
            secondOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[orderType].menuItems[orderNumber])
            if restaurant!.menuCategories[orderType].name == "Special Orders" {
                secondOrder = specialOrder(oldOrder: secondOrder)
            }
            for card in secondOrder.content {
                newOrder!.content.append(card)
            }
            /*
        case "Roll two Side Orders",
             "Roll two Stuffers",
             "Roll two Mainstays":
            var thirdOrder: CurrentOrder
            //secondOrder = CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(oldOrder!.originalItem.specialOrderLink) })!.menuItems[orderNumber])
            thirdOrder = CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(oldOrder!.originalItem.specialOrderLink) })!.menuItems[orderType])
            for card in secondOrder.content {
                newOrder!.content.append(card)
            }
            for card in thirdOrder.content {
                newOrder!.content.append(card)

            }
        case "Roll a Main Dish, add one Drink",
             "Roll a Combo, add one Fries":
             //secondOrder = CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(oldOrder!.originalItem.specialOrderLink) })!.menuItems[orderNumber])
             for card in secondOrder.content {
                 newOrder!.content.append(card)
             }
        case "Holiday Potluck":
            newOrder!.content = ui.pickThreeCards()
            */
        default:
            assert(false)
        }
        return newOrder!
    }
}
