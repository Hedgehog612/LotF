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
// PickNumberOfRoundsView
// How many rounds are we playing?
//------------------------------------------------------------------------------
struct PickNumberOfRoundsView: View {
    var window: NSWindow!
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init() {
        window = FullUI.makeWindow()
        window.contentView = NSHostingView(rootView: self)
    }
    

    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        VStack {
            Spacer()
            
            Text("How many rounds would you like to play?").font(.headline)

            Button(action: {
                self.window.close()
                game.onNumberOfRoundsPicked(1) }) {
                    Text("1")
                }
            Button(action: {
                self.window.close()
                game.onNumberOfRoundsPicked(2) }) {
                    Text("2")
                }
            Button(action: {
                self.window.close()
                game.onNumberOfRoundsPicked(3) }) {
                    Text("3")
                }
            Button(action: {
                self.window.close()
                game.onNumberOfRoundsPicked(4) }) {
                    Text("4")
                }

            Spacer()
        }
        .frame(width: 400, height: 400, alignment: .center)
        .padding()
    }
}
