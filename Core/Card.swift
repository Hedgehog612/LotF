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
enum Card: CaseIterable {
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
    

    //------------------------------------------------------------------------------
    // For concision, we store all the card properties in a single dictionary and
    // access them with helper functions.
    //------------------------------------------------------------------------------
    static let values: [Card: (name: String, score: Int, image: String, color: Color)] = [
        Bun:    ("Bun",         1,      "bunImage",         .yellow),
        Sauce:  ("Sauce",       1,      "sauceImage",       .gray),
        Fries:  ("Fries",       2,      "friesImage",       .pink),
        Drink:  ("Drink",       3,      "drinkImage",       .purple),
        Vegetable:("Vegetable", 3,      "vegetableImage",   .green),
        Cheese: ("Cheese",      4,      "cheeseImage",      .orange),
        Bird:   ("Bird",        5,      "birdImage",        .yellow),
        Fish:   ("Fish",        5,      "fishImage",        .blue),
        Cow:    ("Cow",         5,      "cowImage",         .red),
        Pie:    ("Pie",         6,      "pieImage",         .purple),
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
    // matchesRequirement
    // Does this card match a required ingredient?
    //------------------------------------------------------------------------------
    func matchesRequirement(requirement: Card) -> Bool {
        return requirement == self
            || requirement == .AnyMeat && self.isMeat()
            || requirement == .AnyIngredient
    }
}
