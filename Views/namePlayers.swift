//
//  GameUI.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

//This is the core UI function that will delegate out assembling and updating the game interface
import Foundation
import SwiftUI


//Full of placeholders in place of proper UI right now
//This function determines the number of players. It is called at the beginning of the game.
struct namePlayers: View {
    @State private var name1: String = "Name1"
    @State private var name2: String = "Name2"
    @State private var name3: String = "Name3"
    @State private var name4: String = "Name4"
    @State private var name5: String = "Name5"
    @State private var name6: String = "Name6"
    @State private var name7: String = "Name7"
    @State private var name8: String = "Name8"
    var body: some View {
        VStack {
            Text("Enter the names of three to eight players.")
            TextField("Enter the name of the first player.", text: $name1)
            TextField("Enter the name of the second player.", text: $name2)
            TextField("Enter the name of the third player.", text: $name3)
            TextField("Enter the name of the fourth player.", text: $name4)
            TextField("Enter the name of the fifth player.", text: $name5)
            TextField("Enter the name of the sixth player.", text: $name6)
            TextField("Enter the name of the seventh player.", text: $name7)
            TextField("Enter the name of the eighth player.", text: $name8)
            Button(action: {
                game.playerNames.append(name1)
                game.playerNames.append(name2)
                game.playerNames.append(name3)
                game.playerNames.append(name4)
                game.playerNames.append(name5)
                game.playerNames.append(name6)
                game.playerNames.append(name7)
                game.playerNames.append(name8)
                game.makePlayers()
            }) {
                Text("Submit names")
            }
        }
    }
}
