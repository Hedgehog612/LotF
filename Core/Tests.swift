//
//  Tests.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/23/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//Run tests on startup to make sure that everything's working as expected
class Tests {
    var totalTests: Int
    var passedTests: Int
    var failedTests: [String]
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init() {
        totalTests = 0
        passedTests = 0
        failedTests = []
    }
    
    
    //------------------------------------------------------------------------------
    //runAllTests
    //This delegates out all the testing functions that need to get run
    //------------------------------------------------------------------------------
    func runAllTests() {
        deckTesting()
        cardTesting()
        scoreTesting()
        menuTesting()
        specialRuleTesting()
        playerTesting()
        UITesting()
        testReport()
    }
    
    //------------------------------------------------------------------------------
    //passedTest
    //Call this if the test passed
    //------------------------------------------------------------------------------
    func passedTest() {
        totalTests += 1
        passedTests += 1
    }

    
    
    //------------------------------------------------------------------------------
    //failedTest
    //Call this if the test failed
    //------------------------------------------------------------------------------
    func failedTest(_ testName: String) {
        totalTests += 1
        failedTests.append(testName)
    }
    
    
    //------------------------------------------------------------------------------
    //testReport
    //Reports result of tests
    //------------------------------------------------------------------------------
    func testReport() {
        print("\(passedTests) out of \(totalTests) passed.")
        if failedTests.count > 0 {
            print("\(failedTests.count) failed. Tests failed are:")
            for test in failedTests {
                print(test)
            }
        }
    }
    
    
    //------------------------------------------------------------------------------
    //deckTesting
    //Test dealing cards, matching orders
    //------------------------------------------------------------------------------
    func deckTesting() {
        let deck1 = Deck(cardCounts: [.Bun:5])
        let deck2 = Deck()
        for index in 1...5 {
            deck1.deal(recipient: deck2)
                if deck1.cards.count == 5-index && deck2.cards.count == index {
                    passedTest()
                } else {
                    failedTest("Deal test")
                }
            }
        deck2.deal(recipient: deck1)
        let testOrder = CurrentOrder(originalOrder: MenuItem(name: "Carillon", ingredients: [.Bun:4]))
        if testOrder.doesOrderMatch(submittedOrder: deck2.cards) {
            passedTest()
        } else {
            failedTest("Order match test")
        }
    }
    
    
    //------------------------------------------------------------------------------
    //cardTesting
    //Test card comparison, isMeat
    //------------------------------------------------------------------------------
    func cardTesting() {
        let deck1 = Deck(cardCounts: [.Bun:1, .Sauce:1, .Fries:1, .Bird:1, .Cow:1, .Fish:1])
        for index in 1..<deck1.cards.count {
            if deck1.cards[index] <= deck1.cards[index-1] {
                self.failedTest("Card comparison")
            } else {
                self.passedTest()
            }
        }
        for index in 0...2 {
            if deck1.cards[index].isMeat() {
                self.failedTest("Is meat")
                print(deck1.cards[index])
            } else {
                self.passedTest()
                print(deck1.cards[index])
            }
        }
        for index in 3...5 {
            if deck1.cards[index].isMeat() {
                self.passedTest()
                print(deck1.cards[index])
            } else {
                self.failedTest("Is meat")
                print(deck1.cards[index])
            }
        }
    }
    
    
    //------------------------------------------------------------------------------
    //scoreTesting
    //Test moving cards, tokens upon scoring
    //------------------------------------------------------------------------------
    func scoreTesting() {
        let testPlayer = Player(name: "Test player", image: "Test image", totalScore: 15)
        testPlayer.hand = Deck(cardCounts: [.AnyMeat:2, .Sauce:1, .Short:1, .Bird:1, .Cow:1])
        testPlayer.filledOrder(orderCards: [.AnyMeat, .AnyMeat, .Sauce, .Short, .Bird, .Cow], tokens: 3)
        if testPlayer.score.cards.count == 3 {
            passedTest()
        } else {
            failedTest("Cards moved to score")
        }
        var totalScore = 0
        for card in testPlayer.score.cards {
            totalScore += card.score
        }
        if totalScore == 11 {
            passedTest()
        } else {
            failedTest("Score points")
        }
        if testPlayer.scoreTokens == 3 {
            passedTest()
        } else {
            failedTest("Token scoring")
        }
    }
    
    
    //------------------------------------------------------------------------------
    //menuTesting
    //test menu contents
    //------------------------------------------------------------------------------
    func menuTesting() {
        for restaurant in restaurantList {
            for menuCategory in restaurant.menuCategories {
                for menuItem in menuCategory.menuItems {
                    for ingredients in menuItem.ingredients {
                        if ingredients.value < 1 {
                            failedTest("Incorrect menu value")
                        } else {
                            passedTest()
                        }
                    }
                }
            }
        }
    }
    
    
    //------------------------------------------------------------------------------
    //specialRuleTesting
    //make sure the special rules are working correctly
    //------------------------------------------------------------------------------
    func specialRuleTesting() {

    }
    
    
    //------------------------------------------------------------------------------
    //playerTesting
    //make sure the player functions are working
    //------------------------------------------------------------------------------
    func playerTesting() {
        
    }
    
    
    //------------------------------------------------------------------------------
    //UITesting
    //------------------------------------------------------------------------------
    func UITesting() {
        
    }
}
