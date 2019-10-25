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
// PickRollView
// What's the order for this shift?
//------------------------------------------------------------------------------
struct PickRollView: View {
    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        VStack {
            Spacer()
            
            Text("Pick or roll?").font(.headline)
            
            Button(action: {
                game.onPickRollThisOrder(false) }) {
                    Text("Pick")
                }
            Button(action: {
                game.onPickRollThisOrder(true) }) {
                    Text("Roll")
                }

            Spacer()
        }
        .frame(width: 400, height: 400, alignment: .center)
        .padding()
    }
}
