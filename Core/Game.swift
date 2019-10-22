//
//  Game.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
class Game {
    var currentOrder: CurrentOrder?
    var specialRule: String
    var playerOrder: [Player]
    var nullPile: [Card]
    var stewPot: [Card]
    var timer: Int
    var rolledOrder: Bool
    var restaurant: Restaurant?
    var roundEnd: Bool
    var firstPlayer: Player?
    var playerNames: [String]
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init() {
        specialRule = ""
        playerOrder = []
        firstPlayer = nil
        nullPile = []
        stewPot = []
        timer = 0
        restaurant = nil
        roundEnd = false
        rolledOrder = false
        playerNames = []
    }
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func fillOrder(player: Player) {
        print("Can you fill the order? The order is\(currentOrder!.name) and it contains \(currentOrder?.content). It has been short \(currentOrder?.short) times.")
    }
    
    
    //Placeholder function. This function should get the number of players, names of players, and current restaurant as user input once we have the UI more developed.
    func beginGame() {
        NamePlayers()
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
    
    
    func makePlayers() {
        for name in playerNames {
            playerOrder.append(Player(name: name, image: "Placeholder image", totalScore: 0))
        }
    }
    
    
    //Placeholder function. This function should display all orders in the current restraunt and either allow a rolled or called order with user input.
    func makeOrder() {
        print("It is time to select a new order. The orders available in \(restaurant!.name) are the following:")
        for menuCategory in restaurant!.menuCategories {
            print("\(menuCategory.name): (\(menuCategory.range)).")
            for (index, item) in menuCategory.menuItems.enumerated() {
                print("\(index): \(item)")
            }
        }
        print("Would you like to roll a random order or call an order?")
        //Placeholder decision: Need to accept user input to set rolledOrder
        switch rolledOrder {
        case false:
            print("Please select an order from the list.")
        case true:
            print("You have chosen to roll a random order.")
            let orderType = Int.random(in: 1..<6)
            let orderNumber = Int.random(in: 1..<6)
            currentOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[orderType].menuItems[orderNumber])
            print("Your order is \(currentOrder!.name).")
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
        }
        //Placeholder decision: Need to accept user input to fill or pass order.
        let fillOrder = true
        print("The order is \(currentOrder!.name) and it contains \(currentOrder!.content). The order has been shortened by \(currentOrder!.short) items. Do you wish to fill or pass?")
        switch fillOrder {
            //If the order doesn't get filled, move the active player to the back of the order and keep going
        case false:
            //The player who passes gives a card to the player who rolled or the player to their left, depending
            if rolledOrder {
                playerOrder[0].hand.deal(recipient: firstPlayer!.hand)
            } else {
                playerOrder[0].hand.deal(recipient: playerOrder[1].hand)
            }
            currentOrder!.timesPassed += 1
            let activePlayer = playerOrder.remove(at: 0)
            playerOrder.append(activePlayer)
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
        playerFill = []
        if (currentOrder!.orderMatch(submittedOrder: playerFill)) {
            print("You have matched the order!")
            playerOrder[0].filledOrder(orderCards: playerFill, tokens: currentOrder!.tokens)
            currentOrder = nil
        } else {
            print("You cannot match the order!")
        }
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
    }
}
