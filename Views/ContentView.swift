//
//  ContentView.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import SwiftUI


//------------------------------------------------------------------------------
// ContentView
// Our main app view.
//------------------------------------------------------------------------------
struct ContentView: View {
    var body: some View {
        let player1Deck = Deck(cardCounts: [.Cow: 3, .Fish: 2, .Bun: 1, .Sauce: 3, .Fries: 1])
        
        let currentOrder = CurrentOrder(originalOrder: MenuItem(name: "Fur Piece", ingredients: [.Bun:3, .Cow:2, .Pie:1]))
        return GeometryReader { geometry in 
            HandView(deck: player1Deck)
                .position(x: 800, y: 1010)

            OrderView(currentOrder.content.cards)
                .position(x: 400, y: 50)
        }
        .frame(width: 1600, height: 1200)
        .background(Color.gray)
    }
}


//------------------------------------------------------------------------------
// ContentView_Previews
//------------------------------------------------------------------------------
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Todo: 
//Add the remaining four restaurants
//Code in the special rules for Friedey's Long Wok and McPubihan's restaurants.
//Add tests to make sure everything runs properly
//Get the game to a playable state and begin testing everything for bugs
//

