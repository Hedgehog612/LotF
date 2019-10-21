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
        /*
        let deck = Deck([.Cow: 4, .Fish: 3, .Bun: 2])
        let player1Deck = Deck()
        let player2Deck = Deck()
        let player3Deck = Deck()
 */
        let player1Deck = Deck([.Cow: 3, .Fish: 2, .Bun: 1, .Sauce: 3, .Fries: 1])
        //deck.shuffleAndDeal(recipients: [player1Deck, player2Deck, player3Deck])
        
        let currentOrder = CurrentOrder(originalOrder: MenuItem(name: "Fur Piece", ingredients: [.Bun:3, .Cow:2, .Pie:1]))
        print(currentOrder.content)
        return ZStack {
            /*
            CardView(card: player1Deck.aCard())
                .position(x: 220, y: 400)
            
            CardView(card: player2Deck.aCard())
                .position(x: 520, y: 400)
            
            CardView(card: player3Deck.aCard())
                .position(x: 820, y: 400)
            */
            DeckView(player1Deck)
                .position(x: 400, y: 200)
            /*
            OrderView(currentOrder)
                .position(x: 400, y: 50)
 */
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

//Done: Got cards of a type stacking properly

//Todo: Get card types sorting by point value (l-r ascending)
//Get cards vertically aligned on the bottom (high effort, low reward)
//Display menu orders in orderview
