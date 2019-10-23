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
// Provides a command line interface to the game
//------------------------------------------------------------------------------
class TextUI : GameUI {
    //------------------------------------------------------------------------------
    // pickPlayers
    //------------------------------------------------------------------------------
    override func pickPlayers() {
        addToQueue {
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
            
            game.onPlayersSelected(names: names)
        }
    }


    //------------------------------------------------------------------------------
    // pickRestaurant
    //------------------------------------------------------------------------------
    override func pickRestaurant() {
        addToQueue {
            print("\n\nWhere would you like to dine tonight?")
            for (index, restaurant) in restaurantList.enumerated() {
                print("\(index + 1): \(restaurant.name)")
            }
            
            var pick: Int?
            while pick == nil || pick! <= 0 || pick! >= restaurantList.count {
                var answer: String?
                while answer == nil {
                    answer = readLine()
                }
                pick = Int(answer!)
            }

            game.onRestaurantSelected(restaurantList[pick! - 1])
        }
    }
    
    
    //------------------------------------------------------------------------------
    // pickNumberOfRounds
    //------------------------------------------------------------------------------
    override func pickNumberOfRounds() {
        addToQueue {
            print("\n\nHow many rounds will you play?")

            var numberOfRounds: Int?
            while numberOfRounds == nil || numberOfRounds! <= 0 {
                var answer: String?
                while answer == nil {
                    answer = readLine()
                }
                numberOfRounds = Int(answer!)
            }
            
            game.onNumberOfRoundsPicked(numberOfRounds!)
        }
    }
    
    
    //------------------------------------------------------------------------------
    // rollThisOrder
    //------------------------------------------------------------------------------
    override func rollThisOrder() -> Bool {
        print("\n\nIt's time to pick the next order.")
        print("Y to roll randomly, or N to pick from the menu")

        while true {
            var answer: String?
            while answer == nil {
                answer = readLine()
                if answer == "Y" || answer == "y" { return true }
                if answer == "N" || answer == "n" { return false }
            }
        }
    }


    //------------------------------------------------------------------------------
    // pickOrder
    //------------------------------------------------------------------------------
    override func pickOrder(restaurant: Restaurant) -> MenuItem {
        print("\n\nIt is time to select a new order.")
        print("The orders available in \(restaurant.name) are:")
        for menuCategory in restaurant.menuCategories {
            print("\(menuCategory.name):")
            for (index, item) in menuCategory.menuItems.enumerated() {
                print("\(index): \(item)")
            }
        }

        return restaurant.menuCategories[0].menuItems[0]
    }
    
    
    //------------------------------------------------------------------------------
    // pickFillOrPass
    //------------------------------------------------------------------------------
    override func pickFillOrPass() -> Bool {
        return false
    }
}
