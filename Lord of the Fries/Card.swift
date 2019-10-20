//
//  Card.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation

//------------------------------------------------------------------------------
// Card
//------------------------------------------------------------------------------
enum Card: CaseIterable {
    case Bun
    case Sauce
    case Fries
    case Drink
    case Vegetable
    case Cheese
    case Bird
    case Fish
    case Cow
    case Pie
    
    case AnyMeat
    case AnyIngredient
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    static let values: [Card: (name: String, score: Int, image: String)] = [
        Bun:    ("Bun",        1,      "bunImage"),
        Sauce:  ("Sauce",      1,       "sauceImage"),
    ]
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func name() -> String {
        return Card.values[self]!.name
    }
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func score() -> Int {
        return Card.values[self]!.score
    }
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func image() -> String {
        return Card.values[self]!.image
    }
    

    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func isMeat() -> Bool {
        return self == .Bird || self == .Fish || self == .Cow
    }
    
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    func matchesRequirement(requirement: Card) -> Bool {
        if requirement == self {
            return true
        }
        
        if requirement == .AnyMeat && self.isMeat() {
            return true
        }
        
        if requirement == .AnyIngredient {
            return true
        }
        
        return false
    }
}
