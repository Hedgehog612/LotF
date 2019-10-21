//
//  DeckView.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import SwiftUI


struct DeckView: View {
    let deck : Deck
    
    
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        ZStack {
            Text("Hello")
            /*
            //For loop iterating over each type of card in the dictionary
            //cardType stores the keys
            let totalTypes = deck.cards.values.count
            
            //With a window size of 1200, we restrict the cards to occupying 1000 px
            var currentPosition = 1000/totalTypes
            for cardType in deck.keys {
                //For loop iterating through every card in one type of card
                //deck(cardType) returns number of cards of that type
                for cards in deck(cardType) {
                    //Each card in a given type is 5 px up and to the right of the last one
                    CardView(card: .cardType).position(x: (100+(cards*5)+currentPosition), y: (400+(cards*5)))
                }
            }
            //Each different card type is a fraction of 1000 px away from the last one
            currentPosition += (1000/totalTypes)
 */
        }
    }
}
