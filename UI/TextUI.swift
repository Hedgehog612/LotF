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
        let number = readLine()
        return []
    }
}