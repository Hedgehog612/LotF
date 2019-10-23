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
    
    func doTest(result: Bool, comment: String = "", line: Int = #line) {
        totalTests += 1
        
        if result {
            passedTests += 1
        } else {
            failedTests.append("Line \(line), \(comment)")
        }
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
        let testingCards = Deck(cardCounts: [.Bun:1, .Sauce:1, .Fries:1, .Bird:1, .Cow:1, .Fish:1]).sortedCards
        
        for index in 1..<testingCards.count {
            doTest(result: testingCards[index] > testingCards[index-1], comment: "Card comparison")
        }
        for index in 0...2 {
            if testingCards[index].isMeat() {
                self.failedTest("Is meat")
            } else {
                self.passedTest()
            }
        }
        for index in 3...5 {
            if testingCards[index].isMeat() {
                self.passedTest()
            } else {
                self.failedTest("Is meat")
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
