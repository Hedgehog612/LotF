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
class FullUI : TextUI {
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
        _ = PickPlayersView()
    }
    
    
    //------------------------------------------------------------------------------
    // pickNumberOfRounds
    //------------------------------------------------------------------------------
    override func pickNumberOfRounds() {
        _ = PickNumberOfRoundsView()
    }
    
    
    //------------------------------------------------------------------------------
    // startMainUI
    //------------------------------------------------------------------------------
    override func startMainUI() {
        mainWindow = FullUI.makeWindow()
//        mainWindow.contentView = NSHostingView(rootView: MainView())
    }


    //------------------------------------------------------------------------------
    // pickRestaurant
    //------------------------------------------------------------------------------
    override func pickRestaurant() {
        mainWindow.contentView = NSHostingView(rootView: MainView(mode: .restaurant))
    }
    
    
    //------------------------------------------------------------------------------
    // pickRollThisOrder
    //------------------------------------------------------------------------------
    override func pickRollThisOrder() {
        mainWindow.contentView = NSHostingView(rootView: MainView(mode: .rollOrder))
    }
    
    
    //------------------------------------------------------------------------------
    // pickOrder
    // Choose an item on the menu
    //------------------------------------------------------------------------------
    override func pickOrder() {
        mainWindow.contentView = NSHostingView(rootView: MainView(mode: .pickOrder))
    }
    
    
    //------------------------------------------------------------------------------
    // makeWindow
    //------------------------------------------------------------------------------
    class func makeWindow() -> NSWindow {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1200, height: 1200),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered, defer: false)
        window.center()
        window.makeKeyAndOrderFront(nil)
        
        return window
    }
}
