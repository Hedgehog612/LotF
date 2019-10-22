//
//  CardView.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import SwiftUI


//------------------------------------------------------------------------------
// CardView
// Displays a single card
//------------------------------------------------------------------------------
struct CardView: View, Hashable {
    let card: Card
    let x: CGFloat
    let y: CGFloat
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(card cardIn: Card, x xIn: CGFloat, y yIn: CGFloat) {
        card = cardIn
        x = xIn
        y = yIn
    }
    

    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        GeometryReader { geometry1 in
            GeometryReader { geometry2 in
                Text(self.card.name)
                    .font(.headline)
                    .position(x: 100, y: 18)
                    .frame(width: 200, height: 36, alignment: .center)
                    
                Text(String(self.card.score))
                    .position(x: 170, y: 270)
                    .frame(width: 30, height: 30, alignment: .center)
                    .font(.subheadline)
            }
            .frame(width: 200, height: 300, alignment: .center)
            .background(self.card.color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black))
        }
    .position(x: self.x, y: self.y)
    .frame(width: 200, height: 300, alignment: .center)
    }
}


//------------------------------------------------------------------------------
// CardView_Previews
//------------------------------------------------------------------------------
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .Bird, x: 100, y: 150)
    }
}
