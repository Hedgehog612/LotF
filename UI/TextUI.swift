//
//  TextUI.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
class TextUI : GameUI {
    override func pickPlayers() -> [String] {
        print("How many players would you like (3 - 8)?")
        return []
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
