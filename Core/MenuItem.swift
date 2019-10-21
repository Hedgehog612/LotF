//
//  MenuItem.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
struct MenuItem {
    var name: String
    var ingredients: [Card:Int]
    var cardsMustAllBeDifferent: Bool
    
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init(name nameIn: String, ingredients ingredientsIn: [Card:Int], cardsMustAllBeDifferent cardsMustAllBeDifferentIn: Bool = false) {
        name = nameIn
        ingredients = ingredientsIn
        cardsMustAllBeDifferent = cardsMustAllBeDifferentIn
    }
}