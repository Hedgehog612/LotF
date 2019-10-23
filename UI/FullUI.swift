//
//  FullUI.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/22/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
import Cocoa
import SwiftUI


//------------------------------------------------------------------------------
// FullUI
// The graphical version of our UI. Wisely or not, this uses SwiftUI.
//------------------------------------------------------------------------------
class FullUI : GameUI {
    var window: NSWindow!

    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    override init() {
    }
    
    
    //------------------------------------------------------------------------------
    // pickPlayers
    //------------------------------------------------------------------------------
    override func pickPlayers() {
        // Create the window
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 1200),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Who’s playing?")
        window.makeKeyAndOrderFront(nil)
        
        // Set up our view
        let pickView = PickPlayersView(window: window)
        window.contentView = NSHostingView(rootView: pickView)
    }
}
