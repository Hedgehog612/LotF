//
//  FullUI.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//
//------------------------------------------------------------------------------
class FullUI : GameUI {
    override func pickPlayers() -> [String] {
        return []
    }
    
    override func pickNumberOfRounds() -> Int {
        return 4
    }
}
