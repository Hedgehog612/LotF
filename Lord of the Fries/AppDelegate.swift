//
//  AppDelegate.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa
import SwiftUI


var game = Game(ui: TextUI())
var gameTester: Tests?

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Let's do this thing
        gameTester = Tests()
        gameTester!.runAllTests()
        gameTester = nil
        
        game = Game(ui: FullUI())
        game.beginGame()
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

