//
//  CardStackView.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import SwiftUI


//------------------------------------------------------------------------------
// StackView
// Displays a stack of cards
//------------------------------------------------------------------------------
struct StackView: View, Hashable {
    let cards: [Card]
    let x: CGFloat
    let y: CGFloat
    
    
    //------------------------------------------------------------------------------
    // initializer
    //------------------------------------------------------------------------------
    init(cards cardsIn: [Card], x xIn: CGFloat, y yIn: CGFloat) {
        cards = cardsIn
        x = xIn
        y = yIn
    }
        
        
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        // We build from the last card to the first. The last card is on the bottom,
        // and up and to the right, so we need to start out offset in that direction.
        let baseX = 100 + (cards.count - 1) * 5
        let baseY = 210 - (cards.count - 1) * 5
        
        // Create all the cardviews
        var cardViews = [CardView]()
        for (index, card) in cards.reversed().enumerated() {
            cardViews.append(CardView(card: card, x: CGFloat(baseX - index * 5), y: CGFloat(baseY + index * 5)))
        }

        // Assemble our geometry
        return GeometryReader { geometry1 in
            ForEach(cardViews, id: \.self) { cardView in
                cardView.body
            }
        }
        .position(x: self.x, y: self.y)
        .frame(width: 260, height: 360, alignment: .top)
    }
}


//------------------------------------------------------------------------------
// Preview
//------------------------------------------------------------------------------
struct CardStackView_Previews: PreviewProvider {
    static var previews: some View {
        StackView(cards: [.Cow, .Fish, .Bun, .Drink], x: 130, y: 180)
    }
}
