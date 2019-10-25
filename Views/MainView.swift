//
//  ContentView.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import SwiftUI


var mainWindow: NSWindow!


enum MyMode {
    case restaurant
    case rollOrder
    case pickOrder
}


//------------------------------------------------------------------------------
// MainView
// Our main app view.
//------------------------------------------------------------------------------
struct MainView: View {
    var mode: MyMode
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(mode modeIn: MyMode) {
        mode = modeIn
    }
    
    
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        return GeometryReader { geometry in
            if self.mode == .restaurant {
                PickRestaurantView()
            }
            if self.mode == .rollOrder {
                PickRollView()
            }
            if self.mode == .pickOrder {
                PickOrderView()
            }
            
            HandView(deck: game.players[0].hand)
                .position(x: 800, y: 1010)
        }
        .frame(width: 1600, height: 1200)
        .background(Color.gray)
    }
}
