//
//  GameUI.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import SwiftUI


//------------------------------------------------------------------------------
// PickRestaurant
// How many rounds are we playing?
//------------------------------------------------------------------------------
struct PickRestaurantView: View {
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        VStack {
            Spacer()
            
            Text("Which restaurant would you like for round \(game.currentRound)?").font(.headline)
            
            ForEach(restaurantList, id: \.self) { restaurant in
                Button(action: {
                    game.onRestaurantSelected(restaurant) }) {
                        Text(restaurant.name)
                    }
            }

            Spacer()
        }
        .frame(width: 400, height: 400, alignment: .center)
        .padding()
    }
}
