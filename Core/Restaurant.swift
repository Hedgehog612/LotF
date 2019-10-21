//
//  Restraunt.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
class Restaurant {
    var image: String
    var name: String
    var subTitle: String
    var menuCategories: [MenuCategory]
    var smallDeck: Deck
    var largeDeck: Deck
    
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init(image imageIn: String, name nameIn: String, subTitle subTitleIn: String, menuCategories menuCategoriesIn: [MenuCategory] smallDeck smallDeckIn: Deck, largeDeck largeDeckIn: Deck) {
        image = imageIn
        name = nameIn
        subTitle = subTitleIn
        menuCategories = menuCategoriesIn
        smallDeck = smallDeckIn
        largeDeck = largeDeckIn
    }
}
