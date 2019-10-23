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
    var gameUI: GameUI
    var currentOrder: CurrentOrder?
    var playerOrder: [Player]
    var nullPile: Deck
    var stewPot: Deck
    var timer: Int
    var rolledOrder: Bool
    var restaurant: Restaurant?
    var roundEnd: Bool
    var firstPlayer: Player?
    var numberOfRounds: Int
    var currentRound: Int
    var deck: Deck
    

    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(gameUI gameUIIn: GameUI) {
        gameUI = gameUIIn
        playerOrder = []
        firstPlayer = nil
        nullPile = Deck()
        stewPot = Deck()
        timer = 0
        restaurant = nil
        roundEnd = false
        rolledOrder = false
        numberOfRounds = 0
        currentRound = 1
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
        gameUI.pickPlayers()
    }
    
    
    //------------------------------------------------------------------------------
    // onPlayersSelected
    // Called when the UI has picked the players.
    //------------------------------------------------------------------------------
    func onPlayersSelected(names: [String]) {
        for name in names {
            playerOrder.append(Player(name: name, image: "No image yet"))
        }
        gameUI.pickRestaurant()
    }
    
    
    //------------------------------------------------------------------------------
    // onRestaurantSelected
    // TODO: Restaurant selection should happen at the beginning of each round.
    //------------------------------------------------------------------------------
    func onRestaurantSelected(_ restaurantIn: Restaurant) {
        restaurant = restaurantIn

        // Set up the restaurant
        if playerOrder.count <= 5 {
            deck = restaurant!.smallDeck
        } else {
            deck = restaurant!.largeDeck
        }
        if restaurant!.name == "McPubihan's" {
            for _ in 1...6 {
                deck.deal(recipient: stewPot)
            }
        }

        gameUI.pickNumberOfRounds()
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
        gameUI.startMainUI()
    }
    
    
    


    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func fillOrder(player: Player) {
        print("Can you fill the order? The order is\(currentOrder!.originalItem.name) and it contains \(currentOrder!.content). It has been short \(currentOrder!.short) times.")
    }
    
    
    //The main gameplay loop.
    func playRound() {
        while roundEnd == false {
            makeOrder()
            while currentOrder != nil {
                orderToPlayer()
            }
        }
        scoring()
    }
    
    
    //Placeholder function. This function should display all orders in the current restraunt and either allow a rolled or called order with user input.
    func makeOrder() {
        rolledOrder = gameUI.rollThisOrder()
        switch rolledOrder {
        case false:
            currentOrder = CurrentOrder(originalOrder: gameUI.pickOrder(restaurant: restaurant!))
        case true:
            print("You have chosen to roll a random order.")
            let orderType = Int.random(in: 1..<6)
            let orderNumber = Int.random(in: 1..<6)
            currentOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[orderType].menuItems[orderNumber])
            //Special order rules go here
            if restaurant!.menuCategories[orderType].name == "Special Orders" {
                currentOrder = specialOrder(currentOrder: currentOrder)
            }
            //Donner pass ends your turn
            if currentOrder!.originalItem.name == "Donner Pass" {
                currentOrder = nil
                let activePlayer = playerOrder.remove(at: 0)
                playerOrder.append(activePlayer)
                return
            }
            print("Your order is \(currentOrder!.originalItem.name).")
            //For a rolled order, all passes go to this player
            firstPlayer = playerOrder[0]
        }
        //After selecting the order, it's the next player's turn
        let activePlayer = playerOrder.remove(at: 0)
        playerOrder.append(activePlayer)
    }
    
    
    //Placeholder function. This function gives the current player a chance to fill the order or pass to the next player in line.
    //As the main gameplay loop, we also need to check if anyone's hand is empty at the end
    func orderToPlayer() {
        //Begin by checking if the order has become more short than it currently is
        if currentOrder!.timesPassed == playerOrder.count {
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
        let fillOrPass = gameUI.pickFillOrPass()
        print("The order is \(currentOrder!.originalItem.name) and it contains \(currentOrder!.content). The order has been shortened by \(currentOrder!.short) items. Do you wish to fill or pass?")
        switch fillOrPass {
            //If the order doesn't get filled, move the active player to the back of the order and keep going
        case false:
            passTheOrder()
        case true:
            matchFood()
        }
        for player in playerOrder {
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
        playerFill = gameUI.pickCardsToFill()
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
            playerOrder[0].filledOrder(orderCards: playerFill, tokens: currentOrder!.tokens)
            currentOrder = nil
        } else {
            print("You fail to match the order and must pass the order!")
            passTheOrder()
        }
    }
    
    
    func passTheOrder() {
        //The player who passes gives a card to the player who rolled or the player to their left, depending on if the order was rolled or called
        if rolledOrder {
            playerOrder[0].hand.deal(recipient: firstPlayer!.hand)
        } else {
            playerOrder[0].hand.deal(recipient: playerOrder[1].hand)
        }
        currentOrder!.timesPassed += 1
        let activePlayer = playerOrder.remove(at: 0)
        playerOrder.append(activePlayer)
    }
    
    
    //Placeholder function. This function tallies up the scores of each player at the end of the round.
    func scoring() {
        var roundScores = [Int]()
        for player in playerOrder {
            var roundPoints = 0
            for card in player.score.cards {
                //Score by multiplying the number of cards of each type by the point value of those cards
                roundPoints += card.score
            }
            roundPoints += player.scoreTokens
            print("\(player.name) scored \(roundPoints) this round.")
            var lostPoints = 0
            for card in player.hand.cards {
                lostPoints += card.score
            }
            print("\(player.name) has \(lostPoints) points still in hand.")
            roundPoints -= lostPoints
            player.tempScore = roundPoints
            roundScores.append(player.tempScore)
            print("\(player.name)'s score this round is \(roundPoints)")
            player.totalScore += roundPoints
            print("This brings \(player.name)'s total score to \(player.totalScore).")
        }
        //Move the player with the smallest score to the front
        let minScore = roundScores.min()!
        var movePlayer: Player
        for _ in 1...playerOrder.count {
            if playerOrder[0].tempScore > minScore {
                movePlayer = playerOrder.remove(at: 0)
                playerOrder.append(movePlayer)
            }
        }
        currentRound += 1
        //Reset tempScore, scoreTokens for next round
        for player in playerOrder {
            player.tempScore = 0
            player.scoreTokens = 0
        }
    }
    
    //This function handles special orders
    func specialOrder(currentOrder: CurrentOrder!) -> CurrentOrder {
        var newOrder = currentOrder
        var secondOrder: CurrentOrder
        let orderType = Int.random(in: 1..<6)
        let orderNumber = Int.random(in: 1..<6)
        switch currentOrder.originalItem.name {
        case "Add one Bun",
             "Add one Cheese",
             "Add one Meat",
             "Add one Drink",
             "Add one Fish":
            secondOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[orderType].menuItems[orderNumber])
            if restaurant!.menuCategories[orderType].name == "Special Orders" {
                secondOrder = specialOrder(currentOrder: currentOrder!)
            }
            newOrder!.content += secondOrder.content
        case "Roll two Side Orders",
             "Roll two Stuffers",
             "Roll two Mainstays":
            var thirdOrder: CurrentOrder
            secondOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[currentOrder.originalItem.specialOrderLink].menuItems[orderNumber])
            thirdOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[currentOrder.originalItem.specialOrderLink].menuItems[orderType])
            newOrder!.content += secondOrder.content
            newOrder!.content += thirdOrder.content
        case "Roll a Main Dish, add one Drink",
             "Roll a Combo, add one Fries":
             secondOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[currentOrder.originalItem.specialOrderLink].menuItems[orderNumber])
             newOrder!.content += secondOrder.content
        case "Holiday Potluck":
            newOrder!.content = gameUI.pickThreeCards()
        default:
            assert(false)
        }
        return currentOrder
    }
}
