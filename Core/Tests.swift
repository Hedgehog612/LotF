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
        return
        deckTesting()
        cardTesting()
        scoreTesting()
        menuTesting()
        //specialRuleTesting()
        gameTesting()
        UITesting()
        testReport()
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
    //deckTesting
    //Test dealing cards, matching orders
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
    }
    //TODO: Test complete range set
    //
    
    
    //------------------------------------------------------------------------------
    //specialRuleTesting
    //make sure the special rules are working correctly
    //------------------------------------------------------------------------------
    /*
    func specialRuleTesting() {
        game.restaurant = restaurantList[1]
        var specialTest: CurrentOrder
        specialTest = game.specialOrder(oldOrder: CurrentOrder(originalOrder: MenuItem(name: "Add one Fish", ingredients:
        [.Fish:1])))
        doTest(result: specialTest.content.count > 1, comment: "Special order test: Add one item")
        specialTest = game.specialOrder(oldOrder: CurrentOrder(originalOrder: MenuItem(name: "Roll two Mainstays", ingredients:
            [:], specialOrderLink: 3)))
        doTest(result: specialTest.content.count > 5, comment: "Special order test: Roll two")
        for card in specialTest.content {
            print(card.name)
        }
    }
 */
    
    
    //------------------------------------------------------------------------------
    //gameTesting
    //run through a very crude mock game, testing to make sure everything works as expected
    //------------------------------------------------------------------------------
    func gameTesting() {
        game = Game(ui: TextUI())
        
        game.players = [Player(name: "Test player 1", image: "Test image 1", totalScore:0),
                            Player(name: "Test player 2", image: "Test image 2", totalScore:0),
                            Player(name: "Test player 3", image: "Test image 3", totalScore:0),
                            Player(name: "Test player 4", image: "Test image 4", totalScore:0)]
        game.onRestaurantSelected(restaurantList[0])
        for player in game.players {
            doTest(result: player.hand.cards.count == 13, comment: "Small deck deal to players")
        }
        game.players = [Player(name: "Test player 1", image: "Test image 1", totalScore:0),
                            Player(name: "Test player 2", image: "Test image 2", totalScore:0),
                            Player(name: "Test player 3", image: "Test image 3", totalScore:0),
                            Player(name: "Test player 4", image: "Test image 4", totalScore:0),
                            Player(name: "Test player 5", image: "Test image 5", totalScore:0),
                            Player(name: "Test player 6", image: "Test image 6", totalScore:0)]
        game.onRestaurantSelected(restaurantList[0])
        for player in game.players {
            doTest(result: player.hand.cards.count == 11 || player.hand.cards.count == 12, comment: "Large deck deal to players")
        }
        
        game.players = [
            Player(name: "Test player 1", image: "Test image 1", totalScore:0, score: Deck(cardCounts: [.Bird:8])),
            Player(name: "Test player 2", image: "Test image 2", totalScore:0, score: Deck(cardCounts: [.Bird:6])),
            Player(name: "Test player 3", image: "Test image 3", totalScore:0, score: Deck(cardCounts: [.Bird:4])),
            Player(name: "Test player 4", image: "Test image 4", totalScore:0, score: Deck(cardCounts: [.Bird:2]))]
        
        game.scoring()
        doTest(result: game.players[0].name == "Test player 4", comment: "Scoring player order")
        doTest(result: game.players[1].name == "Test player 1", comment: "Scoring player order")
        doTest(result: game.players[2].name == "Test player 2", comment: "Scoring player order")
        doTest(result: game.players[3].name == "Test player 3", comment: "Scoring player order")
        
        game = Game(ui: TextUI())
    }
    
    
    //------------------------------------------------------------------------------
    //UITesting
    //------------------------------------------------------------------------------
    func UITesting() {
        
    }
}
