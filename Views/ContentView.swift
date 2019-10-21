//
//  ContentView.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import SwiftUI


//------------------------------------------------------------------------------
// ContentView
// Our main app view.
//------------------------------------------------------------------------------
struct ContentView: View {
    var body: some View {
        ZStack {
            CardView(card: .Cow)
                .position(x: 220, y: 400)
            
            CardView(card: .Bun)
                .position(x: 520, y: 400)
            
            CardView(card: .Fish)
                .position(x: 820, y: 400)
        }
        .frame(width: 1200, height: 800, alignment: .center)
    }
}


//------------------------------------------------------------------------------
// ContentView_Previews
//------------------------------------------------------------------------------
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
