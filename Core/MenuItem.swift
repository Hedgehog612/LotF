//
//  MenuItem.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// MenuItem
// A single item on a menu.
//------------------------------------------------------------------------------
struct MenuItem: Hashable {
    var name: String
    var ingredients: [Card:Int]
    var cardsMustAllBeDifferent: Bool
    var specialOrderLink: Int
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(name nameIn: String, ingredients ingredientsIn: [Card:Int], cardsMustAllBeDifferent cardsMustAllBeDifferentIn: Bool = false, specialOrderLink specialOrderLinkIn: Int = 0) {
        name = nameIn
        ingredients = ingredientsIn
        cardsMustAllBeDifferent = cardsMustAllBeDifferentIn
        specialOrderLink = specialOrderLinkIn
    }
    
    
    //------------------------------------------------------------------------------
    // == (for Comparable)
    //------------------------------------------------------------------------------
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.name == rhs.name
    }


    //------------------------------------------------------------------------------
    // hash (for Hashable)
    //------------------------------------------------------------------------------
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
