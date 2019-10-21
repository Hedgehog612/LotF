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
        let deck = Deck([.Cow: 4, .Fish: 3, .Bun: 2])
        let player1Deck = Deck()
        let player2Deck = Deck()
        let player3Deck = Deck()
        deck.shuffleAndDeal(recipients: [player1Deck, player2Deck, player3Deck])
        
        return ZStack {
            CardView(card: player1Deck.aCard())
                .position(x: 220, y: 400)
            
            CardView(card: player2Deck.aCard())
                .position(x: 520, y: 400)
            
            CardView(card: player3Deck.aCard())
                .position(x: 820, y: 400)
        }
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
