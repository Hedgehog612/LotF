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
// PickPlayers
// Full of placeholders in place of proper UI right now
// This function determines the number of players. It is called at the beginning of the game.
//------------------------------------------------------------------------------
struct PickPlayersView: View {
    @State private var name1 = ""
    @State private var name2 = ""
    @State private var name3 = ""
    @State private var name4 = ""
    @State private var name5 = ""
    @State private var name6 = ""
    @State private var name7 = ""
    @State private var name8 = ""
    
    @State private var notEnoughPlayers = true
    
    var window: NSWindow
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(window windowIn: NSWindow) {
        window = windowIn
    }
    

    //------------------------------------------------------------------------------
    // body
    //------------------------------------------------------------------------------
    var body: some View {
        VStack {
            Spacer()
            
            Text("Who's playing?").font(.headline)
            Text("You can have 3 to 8 players").font(.subheadline)

            Group {
                TextField("Player 1", text: $name1, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
                TextField("Player 2", text: $name2, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
                TextField("Player 3", text: $name3, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
                TextField("Player 4", text: $name4, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
                TextField("Player 5", text: $name5, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
                TextField("Player 6", text: $name6, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
                TextField("Player 7", text: $name7, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
                TextField("Player 8", text: $name8, onEditingChanged: { (changed) in self.textChanged(changed: changed) })
            }
            
            Button(action: {
                // TODO: The player can erase a name and then press a button, getting us below 3 valid players
                var names = [String]()
                if self.name1 != "" { names.append(self.name1) }
                if self.name2 != "" { names.append(self.name2) }
                if self.name3 != "" { names.append(self.name3) }
                if self.name4 != "" { names.append(self.name4) }
                if self.name5 != "" { names.append(self.name5) }
                if self.name6 != "" { names.append(self.name6) }
                if self.name7 != "" { names.append(self.name7) }
                if self.name8 != "" { names.append(self.name8) }
                
                self.window.close()
                game.onPlayersSelected(names: names)
                
            }) {
                Text("Let's play!")
            }
            .disabled(self.notEnoughPlayers)

            Spacer()
        }
        .frame(width: 400, height: 400, alignment: .center)
        .padding()
    }
    
    
    //------------------------------------------------------------------------------
    // textChanged
    //------------------------------------------------------------------------------
    func textChanged(changed: Bool) {
        let numberOfPlayers =
            (name1 != "" ? 1 : 0) +
            (name2 != "" ? 1 : 0) +
            (name3 != "" ? 1 : 0) +
            (name4 != "" ? 1 : 0) +
            (name5 != "" ? 1 : 0) +
            (name6 != "" ? 1 : 0) +
            (name7 != "" ? 1 : 0) +
            (name8 != "" ? 1 : 0)
        
        notEnoughPlayers = numberOfPlayers < 3
    }
}
