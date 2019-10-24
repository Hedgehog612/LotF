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
        
    }
    


    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func fillOrder(player: Player) {
        print("Can you fill the order? The order is\(currentOrder!.originalItem.name) and it contains \(currentOrder!.content). It has been short \(currentOrder!.short) times.")
    }
    
    
    //The main gameplay loop.
    func playRound() {
        while roundEnd == false {
            // makeOrder()
            while currentOrder != nil {
                orderToPlayer()
            }
        }
        scoring()
    }
    
    
    //Placeholder function. This function gives the current player a chance to fill the order or pass to the next player in line.
    //As the main gameplay loop, we also need to check if anyone's hand is empty at the end
    func orderToPlayer() {
        //Begin by checking if the order has become more short than it currently is
        if currentOrder!.timesPassed == players.count {
            currentOrder!.timesPassed = 0
            currentOrder!.short += 1
            //Love's Labours Lunch adds tokens when it gets short
            if currentOrder!.originalItem.name == "Love's Labours Lunch" {
                currentOrder?.tokens += 5
            }
        }
        //Cancel the order if it's completely short
        if currentOrder!.short == currentOrder!.content.count {
            print("The order is too short and cannot be filled! Choose a new order.")
            currentOrder = nil
            return
        }
        let fillOrPass = ui.pickFillOrPass()
        print("The order is \(currentOrder!.originalItem.name) and it contains \(currentOrder!.content). The order has been shortened by \(currentOrder!.short) items. Do you wish to fill or pass?")
        switch fillOrPass {
            //If the order doesn't get filled, move the active player to the back of the order and keep going
        case false:
            passTheOrder()
        case true:
            matchFood()
        }
        for player in players {
            if player.hand.cards.count == 0 {
                print("The round has ended!")
                currentOrder = nil
                roundEnd = true
            }
        }
    }
    
    //Placeholder function. This function allows a player to try to fill an order.
    func matchFood() {
        print("You have chosen to fill the order. Please match your cards with the cards in the order.")
        var playerFill: [Card]
        //Placeholder in place of user input
        playerFill = ui.pickCardsToFill()
        if (currentOrder!.doesOrderMatch(submittedOrder: playerFill)) {
            print("You have matched the order!")
            //Ghicciaroni's orders are always worth the same amount of points, even if they're missing items
            if restaurant!.name == "Ghicciaroni's" {
                var playerScore = 0
                var orderScore = 0
                for card in playerFill {
                    playerScore += card.score
                }
                for card in currentOrder!.content {
                    orderScore += card.score
                }
                currentOrder!.tokens += (orderScore - playerScore)
            }
            //Replace "any meat" matches with non-scoring "any meat" cards
            if restaurant!.name == "Montezuma's Mexi-Deli" {
                playerFill = currentOrder!.montezumaMatch(playerCards: playerFill)
            }
            players[0].filledOrder(orderCards: playerFill, tokens: currentOrder!.tokens)
            currentOrder = nil
        } else {
            print("You fail to match the order and must pass the order!")
            passTheOrder()
        }
    }
    
    
    func passTheOrder() {
        //The player who passes gives a card to the player who rolled or the player to their left, depending on if the order was rolled or called
        if rolledOrder {
            players[0].hand.deal(recipient: shiftLeader!.hand)
        } else {
            players[0].hand.deal(recipient: players[1].hand)
        }
        currentOrder!.timesPassed += 1
        let activePlayer = players.remove(at: 0)
        players.append(activePlayer)
    }
    
    
    //Placeholder function. This function tallies up the scores of each player at the end of the round.
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
        currentRound += 1
        //Reset tempScore, scoreTokens for next round
        for player in players {
            player.tempScore = 0
            player.scoreTokens = 0
        }
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
        case "Roll two Side Orders",
             "Roll two Stuffers",
             "Roll two Mainstays":
            var thirdOrder: CurrentOrder
            secondOrder = CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(oldOrder!.originalItem.specialOrderLink) })!.menuItems[orderNumber])
            thirdOrder = CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(oldOrder!.originalItem.specialOrderLink) })!.menuItems[orderType])
            for card in secondOrder.content {
                newOrder!.content.append(card)
            }
            for card in thirdOrder.content {
                newOrder!.content.append(card)

            }
        case "Roll a Main Dish, add one Drink",
             "Roll a Combo, add one Fries":
             secondOrder = CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(oldOrder!.originalItem.specialOrderLink) })!.menuItems[orderNumber])
             for card in secondOrder.content {
                 newOrder!.content.append(card)
             }
        case "Holiday Potluck":
            newOrder!.content = ui.pickThreeCards()
        default:
            assert(false)
        }
        return newOrder!
    }
}
