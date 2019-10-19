//
//  menuCategory.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
struct MenuCategory {
    var name: String
    var range: ClosedRange<Int>
    var canCall: Bool
    var menuItems: [MenuItem]
    
    init(name nameIn: String, range rangeIn: ClosedRange<Int>, canCall canCallIn: Bool = true, menuItems menuItemsIn: [MenuItem]) {
    name = nameIn
    range = rangeIn
    canCall = canCallIn
    menuItems = menuItemsIn
    }
}
