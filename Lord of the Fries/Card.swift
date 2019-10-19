//
//  Card.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
enum Card {
    case Bun
    case Sauce
    case Fries
    case Drink
    case Vegetable
    case Cheese
    case Bird
    case Fish
    case Cow
    case Pie

    func score() -> Int {
        switch self {
            case .Bun:
                return 1
            default:
                return 2
        }
    }
    
    func isMeat() -> Bool {
        switch self {
        case .Bird:
            return true
        default:
            return false
        }
    }
    
    func getImage() -> String {
        return("Put an image in!")
    }
     
    
    func cardName() -> String {
        switch self {
        case .Bun:
            return("Bun")
        default:
            return("Not a valid type!")
        }
    }
}
