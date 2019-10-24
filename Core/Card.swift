//
//  Card.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import SwiftUI


//------------------------------------------------------------------------------
// Card
// A single ingredient card.
//------------------------------------------------------------------------------
enum Card: CaseIterable, Hashable, Comparable {
    
    // These are actual cards that a player can have in their hand.
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
    
    // These are recipe ingredients that don't exist as real cards
    case AnyMeat
    case AnyIngredient
    //Short exists to fill out arrays of cards containing shorts
    case Short
    

    //------------------------------------------------------------------------------
    // For concision, we store all the card properties in a single dictionary and
    // access them with helper functions.
    //------------------------------------------------------------------------------
    static let values: [Card: (name: String, score: Int, image: String, color: Color, symbol: String)] = [
        Bun:            ("Bun",             1,      "bunImage",             .yellow,    "bunSymbol"),
        Sauce:          ("Sauce",           1,      "sauceImage",           .green,     "sauceSymbol"),
        Fries:          ("Fries",           2,      "friesImage",           .pink,      "friesSymbol"),
        Drink:          ("Drink",           3,      "drinkImage",           .purple,    "drinkSymbol"),
        Vegetable:      ("Vegetable",       3,      "vegetableImage",       .init(red: 0.6, green: 0.4, blue: 0.2), "vegetableSymbol"),
        Cheese:         ("Cheese",          4,      "cheeseImage",          .orange,    "cheeseSymbol"),
        Bird:           ("Bird",            5,      "birdImage",            .yellow,    "birdSymbol"),
        Fish:           ("Fish",            5,      "fishImage",            .blue,      "fishSymbol"),
        Cow:            ("Cow",             5,      "cowImage",             .red,       "cowSymbol"),
        Pie:            ("Pie",             6,      "pieImage",             .purple,    "pieSymbol"),
        AnyMeat:        ("Any Meat",        0,      "anyMeatImage",         .gray,     "anyMeatSymbol"),
        AnyIngredient:  ("Any Ingredient",  0,      "AnyIngredientImage",   .gray,     "AnyIngredientSymbol"),
        Short:          ("Short",           0,      "shortImage",           .gray,     "shortSymbol")
    ]
    
    var name: String { Card.values[self]!.name }
    var score: Int { Card.values[self]!.score }
    var image: String { Card.values[self]!.image }
    var color: Color { Card.values[self]!.color }
    

    //------------------------------------------------------------------------------
    // isMeat
    // Is this a meat card?
    //------------------------------------------------------------------------------
    func isMeat() -> Bool {
        return self == .Bird || self == .Fish || self == .Cow
    }
    
    
    //------------------------------------------------------------------------------
    // isRealCard
    // Is this a real card type (i.e. Cow) as opposed to a placeholder type (i.e. AnyMeat)
    //------------------------------------------------------------------------------
    func isRealCard() -> Bool {
        return self == .Bun || self == .Sauce || self == .Fries || self == .Drink
        || self == .Vegetable || self == .Cheese || self == .Bird || self == .Fish
        || self == .Cow || self == .Pie
    }
    
    
    //------------------------------------------------------------------------------
    // matchesRequirement
    // Does this card match a required ingredient?
    //------------------------------------------------------------------------------
    func matchesRequirement(requirement: Card) -> Bool {
        return requirement == self
            || requirement == .AnyMeat && self.isMeat()
            || requirement == .AnyIngredient
    }
    
    
    //------------------------------------------------------------------------------
    // < (for Comparable)
    //------------------------------------------------------------------------------
    static func < (lhs: Card, rhs: Card) -> Bool {
        if lhs.score == rhs.score {
            return lhs.name < rhs.name
        }
        
        return lhs.score < rhs.score
    }
}
