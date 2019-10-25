//
//  menuCategory.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// MenuCategory
// Menus are organized into categories (appetizers, desserts, etc.).
// Each category has a set of MenuItems.
//------------------------------------------------------------------------------
struct MenuCategory: Hashable {
    var name: String                // Name of this category
    var range: ClosedRange<Int>     // Which values on the green dice roll this category?
    var canCall: Bool               // Can you call this category? (If not, you can only roll it)
    var menuItems: [MenuItem]       // All the individual items
    

    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(name nameIn: String, range rangeIn: ClosedRange<Int>, canCall canCallIn: Bool = true, menuItems menuItemsIn: [MenuItem]) {
        name = nameIn
        range = rangeIn
        canCall = canCallIn
        menuItems = menuItemsIn
    }
    
    
    //------------------------------------------------------------------------------
    // == (for Comparable)
    //------------------------------------------------------------------------------
    static func == (lhs: MenuCategory, rhs: MenuCategory) -> Bool {
        return lhs.name == rhs.name
    }


    //------------------------------------------------------------------------------
    // hash (for Hashable)
    //------------------------------------------------------------------------------
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
