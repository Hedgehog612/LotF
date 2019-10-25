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
    var testedHands: Bool
    var ui = TestUI()
    var testedPass: Bool
    
    //------------------------------------------------------------------------------
    //------------------------------------------------------------------------------
    init() {
        totalTests = 0
        passedTests = 0
        failedTests = []
        testedHands = false
        testedPass = false
    }
    
    
    //------------------------------------------------------------------------------
    //runAllTests
    //This delegates out all the testing functions that need to get run
    //------------------------------------------------------------------------------
    func runAllTests() {
        print("Starting testing")
        deckTesting()
        cardTesting()
        scoreTesting()
        menuTesting()
        ui.pickPlayers()
        //specialRuleTesting()
        print("Sanity check")
        testReport()
        ui.stopExecutionQueue()
    }
    

    //------------------------------------------------------------------------------
    // doTest
    //------------------------------------------------------------------------------
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
    //testHandSize
    //Makes sure a 4-player group was dealt the right number of cards for Friedey's Holiday
    //------------------------------------------------------------------------------
    func testHandSize() {
        for player in game.players {
            doTest(result: player.hand.cards.count == 10 || player.hand.cards.count == 11, comment: "Dealing cards to players")
        }
        testedHands = true
    }
    
    
    //------------------------------------------------------------------------------
    //deckTesting
    //Test dealing cards, matching orders
    //Shouldn't need to reference testUI in order to work
    //------------------------------------------------------------------------------
    func deckTesting() {
        let deck1 = Deck(cardCounts: [.Bun:5])
        let deck2 = Deck()
        for index in 1...5 {
            deck1.deal(recipient: deck2)
            doTest(result: deck1.cards.count == 5-index && deck2.cards.count == index, comment: "Deal test")
        }
        deck2.deal(recipient: deck1)
        var testOrder = CurrentOrder(originalOrder: MenuItem(name: "Carillon", ingredients: [.Bun:4]))
        doTest(result: testOrder.doesOrderMatch(submittedOrder: deck2.cards), comment: "Order match test")
        deck2.deal(recipient: deck1)
        deck2.deal(recipient: deck1)
        testOrder = CurrentOrder(originalOrder: MenuItem(name: "Super Amazing Meatless Burger", ingredients: [.Bun:2]))
        doTest(result: testOrder.doesOrderMatch(submittedOrder: deck2.cards), comment: "Order match test")
        deck2.deal(recipient: deck1)
        testOrder = CurrentOrder(originalOrder: MenuItem(name: "Amazing Meatless Burger", ingredients: [.Bun:1]))
        doTest(result: testOrder.doesOrderMatch(submittedOrder: deck2.cards), comment: "Order match test")
    }
    
    
    //------------------------------------------------------------------------------
    //cardTesting
    //Test card comparison, isMeat
    //Doesn't need to reference testUI to work
    //------------------------------------------------------------------------------
    func cardTesting() {
        let testingCards = Deck(cardCounts: [.Bun:1, .Sauce:1, .Fries:1, .Vegetable:1, .Cheese:1, .Bird:1, .Cow:1, .Fish:1, .Pie:1]).sortedCards
        
        for index in 1..<testingCards.count {
            doTest(result: testingCards[index] > testingCards[index-1], comment: "Card comparison")
        }
        for index in 0...4 {
            doTest(result: !testingCards[index].isMeat(), comment: "Is not meat")
        }
        for index in 5...7 {
            doTest(result: testingCards[index].isMeat(), comment: "Is meat")
        }
        doTest(result: !testingCards[8].isMeat(), comment: "Is not meat")
    }
    
    
    //------------------------------------------------------------------------------
    //scoreTesting
    //Test moving cards, tokens upon scoring
    //Will want to integrate this into TestUI
    //------------------------------------------------------------------------------
    func scoreTesting() {
        let testPlayer = Player(name: "Test player", image: "Test image", totalScore: 15)
        testPlayer.hand = Deck(cardCounts: [.AnyMeat:2, .Sauce:1, .Short:1, .Bird:1, .Cow:1])
        testPlayer.filledOrder(orderCards: [.AnyMeat, .AnyMeat, .Sauce, .Short, .Bird, .Cow], tokens: 3)
        doTest(result: testPlayer.score.cards.count == 3, comment: "Cards moved to score")
        var totalScore = 0
        for card in testPlayer.score.cards {
            totalScore += card.score
        }
        doTest(result: totalScore == 11, comment: "Score points")
        doTest(result: testPlayer.scoreTokens == 3, comment: "Token scoring")
    }
    
    
    //------------------------------------------------------------------------------
    //menuTesting
    //test menu contents
    //Does not need to be integrated into testUI
    //------------------------------------------------------------------------------
    func menuTesting() {
        for restaurant in restaurantList {
            for menuCategory in restaurant.menuCategories {
                for menuItem in menuCategory.menuItems {
                    for ingredients in menuItem.ingredients {
                        doTest(result: ingredients.value >= 1, comment: "Incorrect menu value")
                    }
                }
            }
        }
        for restaurant in restaurantList {
            var orderCounter = 0
            for menuCategory in restaurant.menuCategories {
                for _ in menuCategory.menuItems {
                    orderCounter += 1
                }
            }
            doTest(result: orderCounter == 24, comment: "24 orders in menu")
        }
    }
    
    
    //------------------------------------------------------------------------------
    //specialRuleTesting
    //make sure the special rules are working correctly
    //Add to testUI
    //------------------------------------------------------------------------------
    
    func specialRuleTesting() {
        game.restaurant = restaurantList[1]
        var specialTest: CurrentOrder
        specialTest = game.specialOrder(oldOrder: CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(6) })!.menuItems[2]))
        doTest(result: specialTest.content.cards.count > 1, comment: "Special order test: Add one item")
        specialTest = game.specialOrder(oldOrder: CurrentOrder(originalOrder: game.restaurant.menuCategories.first(where: { $0.range.contains(6) })!.menuItems[5]))
        doTest(result: specialTest.content.cards.count > 5, comment: "Special order test: Roll two")
        for card in specialTest.content.cards {
            print(card.name)
        }
    }
}

//TODO: Rebuild test function to use a dedicated TestUI instead of snipping bits off of TextUI
//Rebuid tests to run through a mock game instead of taking snippets
//Set up TextUI to accept input about filling orders
