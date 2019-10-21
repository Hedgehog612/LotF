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
struct CardView: View {
    let card: Card
    

    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        ZStack {
            Text(card.name)
                .font(.headline)
                .frame(width: 200, height: 25, alignment: .center)
                .position(x: 100, y: 25)
            
            Text(String(card.score))
                .font(.subheadline)
                .frame(width: 30, height: 30, alignment: .center)
                .position(x: 170, y: 270)
        }
        .frame(width: 200, height: 300, alignment: .center)
        .background(card.color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black))
    }
}


//------------------------------------------------------------------------------
// CardView_Previews
//------------------------------------------------------------------------------
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .Bird)
    }
}
