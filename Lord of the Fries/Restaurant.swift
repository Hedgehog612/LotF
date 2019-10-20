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
    
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init(image imageIn: String, name nameIn: String, subTitle subTitleIn: String, menuCategories menuCategoriesIn: [MenuCategory]) {
        image = imageIn
        name = nameIn
        subTitle = subTitleIn
        menuCategories = menuCategoriesIn
    }
}
