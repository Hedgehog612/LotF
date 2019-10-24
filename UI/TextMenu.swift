//
//  TextMenu.swift
//  Lord of the Fries
//
//  Created by Matt Bamberger on 10/24/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
// TextMenu
// Provides a simple and robust way to present the user with a set of options.
// Each option is presented with a number and the user just picks the number they
// want. When a valid option is selected, we call the appropriate closure.
//------------------------------------------------------------------------------
class TextMenu {
    var prompt: String
    var nextNumber = 1
    var choices = [(number: Int?, text: String, onSelect: (() -> ())?)]()
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(prompt promptIn: String) {
        prompt = promptIn
    }
    
    
    //------------------------------------------------------------------------------
    // addChoice
    // Add a new choice, with descriptive text and a closure to call if this
    // choice is selected.
    //------------------------------------------------------------------------------
    func addChoice(_ text: String, onSelect: @escaping () -> ()) {
        choices.append((number: nextNumber, text: text, onSelect: onSelect))
        nextNumber += 1
    }
    
    
    //------------------------------------------------------------------------------
    // addDivider
    // Adds non-selectable dividing text between choices.
    //------------------------------------------------------------------------------
    func addDivider (_ text: String) {
        choices.append((number: nil, text: text, onSelect: nil))
    }
    
    
    //------------------------------------------------------------------------------
    // execute
    // We're done building the menu. Present it to the user, get a valid selection,
    // and call the appropriate closure.
    //------------------------------------------------------------------------------
    func execute() {
        print("\n\n\(prompt)")

        // Print all the available options
        for (number, text, _) in choices {
            if number == nil {
                print("\n\(text)")
            } else {
                print("\(number!): \(text)")
            }
        }
        
        // Get a valid selection
        var selection: Int?
        while selection == nil || selection! < 1 || selection! >= nextNumber {
            var answer: String?
            while answer == nil {
                answer = readLine()
            }
            selection = Int(answer!)
        }

        // Call the appropriate closure for our selection
        game.ui.addToQueue {
            self.choices.first(where: { $0.number == selection })!.onSelect!()
        }
    }
}
