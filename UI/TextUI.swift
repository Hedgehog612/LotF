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
    override func pickPlayers() -> [String] {
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
        
        return names
    }


    //------------------------------------------------------------------------------
    // pickRestaurant
    //------------------------------------------------------------------------------
    override func pickRestaurant() -> Restaurant {
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

        return restaurantList[pick!]
    }
    
    override func pickRestaurant() -> Restaurant {
        print("What restaurant would you like?")
        for restaurant in restaurantList {
            print(restaurant.name)
        }
        return restaurantList[0]
    }
    
    override func pickNumberOfRounds() -> Int {
        print("How many rounds will you play?")
        return 4
    }
}
