//
//  DeckView.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import SwiftUI


struct QuiteUgly: Hashable {
    var card: Card
    var x: CGFloat
    var y: CGFloat
}


struct DeckView: View {
    let deck : Deck
    var views = [AnyView]()
    let foobar = ["Hello", "Goodbye"]
    var uglyThings = [QuiteUgly]()
    
    
    init(_ deckIn: Deck) {
        deck = deckIn
        
        //For loop iterating over each type of card in the dictionary
        //cardType stores the keys
        let totalTypes = deck.cards.filter({ $0.1 > 0}).count
        //print("total types are: \(totalTypes)")
        
        //With a window size of 1200, we restrict the cards to occupying 1000 px
        var currentPosition = Int(1200 / totalTypes)
        
        for (card, count) in deck.cards where count > 0 {
            print("Card/count is: \(card) \(count)")
            for index in 0..<count {
                uglyThings.append(QuiteUgly(card: card, x: CGFloat(100 - (index * 5) + currentPosition), y: CGFloat(400 + index * 5)))
            }
            currentPosition += 1200 / totalTypes
        }
    }
    
    
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {

        ZStack {
            ForEach(uglyThings, id: \.self) { uglyThing in
                CardView(card: uglyThing.card)
                    .position(x: uglyThing.x, y: uglyThing.y)
            }
        }
    }
}
