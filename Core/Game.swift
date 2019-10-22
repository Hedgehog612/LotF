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
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init(specialRule specialRuleIn: String, playerOrder playerOrderIn: [Player]) {
        specialRule = specialRuleIn
        playerOrder = playerOrderIn
        nullPile = []
        stewPot = []
        timer = 0
        rolledOrder = false
        restaurant = nil
        roundEnd = false
    }
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func fillOrder(player: Player) {
        print("Can you fill the order? The order is\(currentOrder!.name) and it contains \(currentOrder?.content). It has been short \(currentOrder?.short) times.")
    }
    
    
    //Placeholder function. This function should get the number of players, names of players, and current restaurant as user input once we have the UI more developed.
    func beginGame() {
        
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
        case rolledOrder == false:
            print("Please select an order from the list.")
        case rolledOrder == true:
            print("You have chosen to roll a random order.")
            let orderType = Int.random(in: 1..<6)
            let orderNumber = Int.random(in: 1..<6)
            currentOrder = CurrentOrder(originalOrder: restaurant!.menuCategories[orderType].menuItems[orderNumber])
            print("Your order is \(currentOrder!.name).")
        default:
            assert(false)
        }
        //After selecting the order, it's the next player's turn
        let activePlayer = playerOrder.remove(at: 0)
        playerOrder.append(activePlayer)
    }
    
    
    //Placeholder function. This function gives the current player a chance to fill the order or pass to the next player in line.
    //As the main gameplay loop, we also need to check if anyone's hand is empty at the end
    func orderToPlayer() {
        let activePlayer = playerOrder[0]
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
        case fillOrder == false:
            currentOrder!.timesPassed += 1
            playerOrder.remove(at: 0)
            playerOrder.append(activePlayer)
        case fillOrder == true:
            matchFood()
        default:
            assert(false)
        }
        for player in playerOrder {
            if player.hand.count == 0 {
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
        for player in playerOrder {
            var roundPoints = 0
            for card in player.score {
                //Score by multiplying the number of cards of each type by the point value of those cards
                roundPoints += card.value * card.key.score
            }
            roundPoints += player.scoreTokens
            print("\(player.name) scored \(roundPoints) this round.")
            var lostPoints = 0
            for card in player.hand {
                lostPoints += card.value * card.key.score
            }
            print("\(player.name) has \(lostPoints) points still in hand.")
            roundPoints -= lostPoints
            player.tempScore = roundPoints
            print("\(player.name)'s score this round is \(roundPoints)")
            player.totalScore += roundPoints
            print("This brings \(player.name)'s total score to \(player.totalScore).") 
        }
    }
}
