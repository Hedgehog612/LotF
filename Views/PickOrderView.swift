//
//  PickOrderView.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/25/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import SwiftUI


//------------------------------------------------------------------------------
// PickOrderView
// What's the order for this shift?
//------------------------------------------------------------------------------
struct PickOrderView: View {
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        VStack {
            Spacer()
            
            Text("What item would you like to order?").font(.headline)
            
            ForEach(game.restaurant!.menuCategories, id: \.self) { category in
                Group {
                    Text(category.name).font(.subheadline)
                    
                    ForEach(category.menuItems, id: \.self) { menuItem in
                        Button(action: {
                            game.onPickedOrder(menuItem) }) {
                                Text(menuItem.name)
                        }
                    }
                    
                    Spacer()
                }
            }

            Spacer()
        }
        .frame(width: 1600, height: 800, alignment: .center)
        .padding()
    }
}
