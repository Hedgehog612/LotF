//
//  AppDelegate.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/21/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Cocoa
import SwiftUI


var game = Game(gameUI: GameUI.makeUI(.text))


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Let's do this thing
        game.beginGame()
        
        /*
        while game.currentRound <= game.numberOfRounds {
            game.playRound()
        }
 */
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

