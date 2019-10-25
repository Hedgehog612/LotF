//
//  Restraunt.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//


import Foundation


//------------------------------------------------------------------------------
// Restaurant
// A single restaurant, with associated menu and special rules.
//------------------------------------------------------------------------------
class Restaurant: Hashable {
    var image: String
    var name: String
    var subTitle: String
    var menuCategories: [MenuCategory]
    var smallDeck: Deck
    var largeDeck: Deck
    var specialRule: String
    
    
    //------------------------------------------------------------------------------
    // init
    //------------------------------------------------------------------------------
    init(image imageIn: String, name nameIn: String, subTitle subTitleIn: String, menuCategories menuCategoriesIn: [MenuCategory], smallDeck smallDeckIn: Deck, largeDeck largeDeckIn: Deck, specialRule specialRuleIn: String) {
        image = imageIn
        name = nameIn
        subTitle = subTitleIn
        menuCategories = menuCategoriesIn
        smallDeck = smallDeckIn
        largeDeck = largeDeckIn
        specialRule = specialRuleIn
    }
    
    
    //------------------------------------------------------------------------------
    // == (for Comparable)
    //------------------------------------------------------------------------------
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name
    }


    //------------------------------------------------------------------------------
    // hash (for Hashable)
    //------------------------------------------------------------------------------
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

//Four restaurants and six point five special rules (McPubihan's has the stew pot but not the option to use it) have been built.
var restaurantList = [
Restaurant(
    image:      "Ratherbee's Zombie",
    name:       "Ratherbee's Steakhouse",
    subTitle:   "Home of the Mighty Cholesterol Onion",
    menuCategories: [
        MenuCategory(
            name: "Appetizers",
            range: 1...2,
            menuItems: [
                MenuItem(name: "Donner Pass", ingredients:
                    [:]),
                MenuItem(name: "Clam Before the Storm", ingredients:
                    [.Fish:1]),
                MenuItem(name: "Mighty Cholesterol Onion", ingredients:
                    [.Vegetable:1]),
                MenuItem(name: "Triple Thick Milkshake", ingredients:
                    [.Drink:1, .Cheese:1]),
                MenuItem(name: "Paul Bunion", ingredients:
                    [.Fries:1, .Vegetable:1, .Cheese:1]),
                MenuItem(name: "Patriotic Chicken Vegetable Medley", ingredients:
                    [.Vegetable:1, .Bird:1])]),
        MenuCategory(
            name: "Burgers",
            range: 3...4,
            menuItems: [
                MenuItem(name: "Amazing Meatless Burger", ingredients:
                    [.Bun:1]),
                MenuItem(name: "Super Amazing Meatless Burger", ingredients:
                    [.Bun:2]),
                MenuItem(name: "Bum Steer", ingredients:
                    [.Bun:1, .Bird:1]),
                MenuItem(name: "Fur Piece", ingredients:
                    [.Bun:1, .Cow:1, .Pie:1]),
                MenuItem(name: "Fishabunga", ingredients:
                    [.Bun:1, .Cheese:1, .Fish:1]),
                MenuItem(name: "Claim Jumper", ingredients:
                    [.Bun:1, .Sauce:1, .Fries:1, .Vegetable:1, .Cheese:1, .Bird:1, .Cow:1])]),
        MenuCategory(
            name: "Fat Meal Deals",
            range: 5...5,
            menuItems: [
                MenuItem(name: "Salmon Rushdie", ingredients:
                    [.Sauce:1, .Vegetable:1, .Cheese:1, .Fish:1]),
                MenuItem(name: "Manifest Destiny", ingredients:
                    [.Sauce:1, .Drink:1, .Cheese:1, .Bird:1]),
                MenuItem(name: "Intestinal Fortitude", ingredients:
                    [.Sauce:1, .Bird:1, .Cow:1, .Fish:1]),
                MenuItem(name: "Pretty Good Corral", ingredients:
                    [.Drink:1, .Vegetable:1, .Cow:2, .Pie:1]),
                MenuItem(name: "We'll Fry Anything!", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Vegetable:1, .Cheese:1, .Pie:1]),
                MenuItem(name: "Bovine Recombinant Yum, Yum, Yum!", ingredients:
                    [.Bun:2, .Drink:2, .Cheese:1, .Cow:1])]),
        MenuCategory(
            name: "Drinks",
            range: 6...6,
            menuItems: [
                MenuItem(name: "Covered Wagon", ingredients:
                    [.Drink:1]),
                MenuItem(name: "Blindfolded Pioneer", ingredients:
                    [.Drink:1, .Pie:1]),
                MenuItem(name: "Aertery Blocker", ingredients:
                    [.Sauce:1, .Fries:1, .Drink:1, .Cheese:1]),
                MenuItem(name: "Heart Pounder", ingredients:
                    [.Sauce:1, .Drink:1, .Cow:1]),
                MenuItem(name: "Synaptic Relay Deteriorator", ingredients:
                    [.Drink:1, .Bird:1, .Fish:1]),
                MenuItem(name: "Lying Dead On the Floor", ingredients:
                    [.Sauce:1, .Drink:1, .Bird:1, .Cow:1, .Fish:1])])],
    smallDeck: Deck(
        cardCounts: [.Bun:9, .Sauce:4, .Fries:3, .Drink:6, .Vegetable:6, .Cheese:6, .Cow:5, .Fish:5, .Bird:5, .Pie:3]),
    largeDeck: Deck(
        cardCounts: [.Bun:11, .Sauce:6, .Fries:5, .Drink:9, .Vegetable:8, .Cheese:8, .Cow:7, .Fish:6, .Bird:7, .Pie:4]),
    specialRule: "Yes, the Donner Pass is nothing. If it's the order, the leader passes to the left."),

    Restaurant(
    image:      "Friedey's Holiday Zombie",
    name:       "Friedey's Holiday Menu",
    subTitle:   "Friedey's Celebrates the Festival of the Season",
    menuCategories: [
        MenuCategory(
            name: "Stuffers",
            range: 1...2,
            menuItems: [
                MenuItem(name: "David Copperfield", ingredients:
                    [.Cheese:1]),
                MenuItem(name: "Nicholas Nickleby", ingredients:
                    [.Fries:1]),
                MenuItem(name: "Little Match Girl", ingredients:
                    [.Bird:2]),
                MenuItem(name: "Oliver Twist", ingredients:
                    [.Bun:1]),
                MenuItem(name: "Wassail, Wassail", ingredients:
                    [.Drink:2]),
                MenuItem(name: "Carillon", ingredients:
                    [.Bun:4])]),
        MenuCategory(
            name: "Mainstays",
            range: 3...4,
            menuItems: [
                MenuItem(name: "Donner on Blitzen", ingredients:
                    [.Bun:1, .Cow:2]),
                MenuItem(name: "Friendly Beasts", ingredients:
                    [.Cow:1, .Fish: 1, .Bird: 1]),
                MenuItem(name: "Big Bowl o' Jelly", ingredients:
                    [.Drink:1, .Cheese:1, .Fish:1]),
                MenuItem(name: "Loaves and Fishes", ingredients:
                    [.Bun:2, .Fish:2]),
                MenuItem(name: "Jacob Marley", ingredients:
                    [.Bun:1, .Fries:2, .Cheese:1]),
                MenuItem(name: "Ebenezer Scrooge", ingredients:
                    [.Drink:3, .Bird:1])]),
        MenuCategory(
            name: "Holiday Meals",
            range: 5...5,
            menuItems: [
                MenuItem(name: "Last Supper", ingredients:
                    [.Bun:1, .Drink:1]),
                MenuItem(name: "Good King Wenceslaus", ingredients:
                    [.Fries:1, .Drink:1, .Cow:1]),
                MenuItem(name: "Adoration of the Baby Cheeses", ingredients:
                    [.Cheese:3]),
                MenuItem(name: "Fourth Day of Christmas", ingredients:
                    [.Bird:4]),
                MenuItem(name: "Winter Spending Festival", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Cheese:1, .Fish:1]),
                MenuItem(name: "Papa Christmas", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Cheese:1, .Cow:1, .Pie:1])]),
        MenuCategory(
            name: "Special Orders",
            range: 6...6,
            canCall: false,
            menuItems: [
                MenuItem(name: "Add one Bun", ingredients:
                    [.Bun:1]),
                MenuItem(name: "Add one Drink", ingredients:
                    [.Drink:1]),
                MenuItem(name: "Add one Fish", ingredients:
                    [.Fish:1]),
                MenuItem(name: "Roll two Stuffers", ingredients:
                    [:], specialOrderLink: 1),
                MenuItem(name: "Roll two Mainstays", ingredients:
                    [:], specialOrderLink: 3),
                MenuItem(name: "Holiday Potluck", ingredients:
                    [:])])],
    smallDeck: Deck(
        cardCounts: [.Bun:10, .Fries:4, .Drink:8, .Cheese:5, .Cow:4, .Fish:5, .Bird:6, .Pie:1]),
    largeDeck: Deck(
        cardCounts: [.Bun:12, .Fries:6, .Drink:12, .Cheese:7, .Cow:6, .Fish:8, .Bird:8, .Pie:1]),
    specialRule: "The last category on the menu is Special Orders, which add ingredients to regular orders. Special Orders can only be rolled, not called."),
    
    Restaurant(
    image:      "Friedey's Zombie",
    name:       "Friedey's Restaurant",
    subTitle:   "The Fast Foot Restaurant of the Damned",
    menuCategories: [
        MenuCategory(
            name: "Side Orders",
            range: 1...2,
            menuItems: [
                MenuItem(name: "Small Fry", ingredients:
                    [.Fries:1]),
                MenuItem(name: "Small Drink", ingredients:
                    [.Drink:1]),
                MenuItem(name: "Cod Piece", ingredients:
                    [.Fish:1]),
                MenuItem(name: "Breakfast Muffin", ingredients:
                    [.Bun:1, .Cheese:1]),
                MenuItem(name: "Teething Vegan", ingredients:
                    [.Bun:1, .Drink:1]),
                MenuItem(name: "Lord of the Fries", ingredients:
                    [.Fries:3])]),
        MenuCategory(
            name: "Main Dishes",
            range: 3...4,
            menuItems: [
                MenuItem(name: "Cowabunga", ingredients:
                    [.Bun:1, .Cow:1]),
                MenuItem(name: "Chickabunga", ingredients:
                    [.Bun:1, .Bird: 1]),
                MenuItem(name: "Cheezabunga", ingredients:
                    [.Bun:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Chickacheezabunga", ingredients:
                    [.Bun:1, .Cheese:1, .Bird:1]),
                MenuItem(name: "J. Robert Lucky", ingredients:
                    [.Cheese:1, .Bird:2, .Cow:1]),
                MenuItem(name: "Old Man and the Sea", ingredients:
                    [.Drink:3, .Fish:1])]),
        MenuCategory(
            name: "Combo Meals",
            range: 5...5,
            menuItems: [
                MenuItem(name: "Cowabunga Conga", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Cow:1]),
                MenuItem(name: "Chickabunga Conga", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Bird:1]),
                MenuItem(name: "Cheezabunga Conga", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Feast of the Innocents", ingredients:
                    [.Fries:2, .Drink:1, .Fish:2]),
                MenuItem(name: "Meat Munch", ingredients:
                    [.Fries:1, .Drink:1, .Bird:1, .Cow:1, .Fish:1]),
                MenuItem(name: "Patriarch", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Cheese:1, .Fish:1, .Pie:1])]),
        MenuCategory(
            name: "Special Orders",
            range: 6...6,
            canCall: false,
            menuItems: [
                MenuItem(name: "Add one Bun", ingredients:
                    [.Bun:1]),
                MenuItem(name: "Add one Cheese", ingredients:
                    [.Cheese:1]),
                MenuItem(name: "Add one Meat", ingredients:
                    [.AnyMeat:1]),
                MenuItem(name: "Roll Two Side Orders", ingredients:
                    [:], specialOrderLink: 1),
                MenuItem(name: "Roll a Main Dish, add one Drink", ingredients:
                    [.Drink:1], specialOrderLink: 3),
                MenuItem(name: "Roll a Combo, add one Fries", ingredients:
                    [.Fries:1], specialOrderLink: 5)])],
    smallDeck: Deck(
        cardCounts: [.Bun:8, .Fries:8, .Drink:8, .Cheese:5, .Cow:4, .Fish:4, .Bird:4, .Pie:1]),
    largeDeck: Deck(
        cardCounts: [.Bun:12, .Fries:12, .Drink:12, .Cheese:8, .Cow:6, .Fish:6, .Bird:6, .Pie:1]),
    specialRule: "The last category on the menu is Special Orders, which add ingredients to regular orders. Special Orders can only be rolled, not called."),
    
    Restaurant(
    image:      "LLL's Zombie",
    name:       "Love's Labours Lunch",
    subTitle:   "Delicate and Edible English Cuisine",
    menuCategories: [
        MenuCategory(
            name: "Starters",
            range: 1...2,
            menuItems: [
                MenuItem(name: "Spanish Inquisition", ingredients:
                    [.Fries:1]),
                MenuItem(name: "Black Death", ingredients:
                    [.Cheese:1, .Fish:1]),
                MenuItem(name: "Trafalgar Squares", ingredients:
                    [.Vegetable:1, .Cheese:1]),
                MenuItem(name: "One S'More into the Breach", ingredients:
                    [.Cow:1, .Pie:1]),
                MenuItem(name: "English Breakfast", ingredients:
                    [.Fries:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Bunday Floody Bunday", ingredients:
                    [.Bun:2, .Drink:2])]),
        MenuCategory(
            name: "Soups",
            range: 3...4,
            menuItems: [
                MenuItem(name: "Just Barley Soup", ingredients:
                    [.Vegetable:1]),
                MenuItem(name: "An Unbearable Likeness of Beans", ingredients:
                    [.Vegetable:1, .Bird: 1]),
                MenuItem(name: "Grey Stuff in a Pot", ingredients:
                    [.Vegetable:1, .Cow:1]),
                MenuItem(name: "Brown Stuff in a Pot", ingredients:
                    [.Vegetable:1, .Cheese:1, .Fish:1]),
                MenuItem(name: "Crown Gruel", ingredients:
                    [.Drink:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Bovine Spongiform Yum, Yum, Yum!", ingredients:
                    [.Bun:2, .Drink:1, .Cow:1])]),
        MenuCategory(
            name: "Sandwiches",
            range: 5...5,
            menuItems: [
                MenuItem(name: "High Road", ingredients:
                    [.Bun:1, .Cow:1]),
                MenuItem(name: "Low Road", ingredients:
                    [.Bun:1, .Fish:1]),
                MenuItem(name: "Guy Fawkes", ingredients:
                    [.Bun:1, .Cheese:1, .Bird:1]),
                MenuItem(name: "Rozencrantz & Guildenstern", ingredients:
                    [.Bun:1, .Fries:2]),
                MenuItem(name: "Two Gentlemen of Verona", ingredients:
                    [.Bun:1, .Bird:2]),
                MenuItem(name: "Star Cross'd Lovers", ingredients:
                    [.Bun:1, .Cheese:1, .Cow:1, .Fish:1])]),
        MenuCategory(
            name: "Main Courses",
            range: 6...6,
            menuItems: [
                MenuItem(name: "Mutton Jeff", ingredients:
                    [.Fries:1, .Drink:1, .Vegetable:1, .Cow:1]),
                MenuItem(name: "Frying Dutchman", ingredients:
                    [.Fries:1, .Drink:1, .Fish:2, .Pie:1]),
                MenuItem(name: "Winston Churchill", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Cheese:1, .Cow:1, .Pie:1]),
                MenuItem(name: "White Man's Bird 'n Cheese", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Cheese:1, .Bird:1, .Pie:1]),
                MenuItem(name: "Madness of King George III", ingredients:
                    [.Bun:1, .Drink:6]),
                MenuItem(name: "Magna Carda with a side of Fries", ingredients:
                    [.Bun:1, .Fries:1, .Drink:1, .Vegetable:1, .Cheese:1, .Bird:1, .Fish:1, .Pie:1])])],
    smallDeck: Deck(
        cardCounts: [.Bun:7, .Fries:5, .Drink:7, .Vegetable:5, .Cheese:6, .Cow:6, .Fish:4, .Bird:3, .Pie:3]),
    largeDeck: Deck(
        cardCounts: [.Bun:10, .Fries:7, .Drink:10, .Vegetable:7, .Cheese:8, .Cow:8, .Fish:6, .Bird:5, .Pie:4]),
    specialRule: "Each time an order goes around the table unfilled, it becomes worth five extra points. These points are tracked with tokens."),
    
    Restaurant(
    image:      "Ghicciaroni's Zombie",
    name:       "Ghicciaroni's",
    subTitle:   "Italian Full-Service Buffet",
    menuCategories: [
        MenuCategory(
            name: "Antipasto",
            range: 1...2,
            menuItems: [
                MenuItem(name: "Friend of Mine", ingredients:
                    [.Bird:1]),
                MenuItem(name: "Friend of Ours", ingredients:
                    [.Fish:1]),
                MenuItem(name: "Caesar's Ghost", ingredients:
                    [.Vegetable:1, .Cheese:1, .Pie:1]),
                MenuItem(name: "Amerigo Vespucci", ingredients:
                    [.Bun:1, .Sauce:1]),
                MenuItem(name: "Cosi Fan Tutte", ingredients:
                    [.Bird:1, .Pie:1]),
                MenuItem(name: "The Old Republic", ingredients:
                    [.Vegetable:2, .Cow:1])]),
        MenuCategory(
            name: "Pasta",
            range: 3...3,
            menuItems: [
                MenuItem(name: "Chicken al Friedey's", ingredients:
                    [.Sauce:1, .Cheese:1, .Bird:1]),
                MenuItem(name: "Cowabungini", ingredients:
                    [.Bun:1, .Sauce: 1, .Cow:1]),
                MenuItem(name: "Carpe de Diem", ingredients:
                    [.Sauce:1, .Vegetable:1, .Fish:1]),
                MenuItem(name: "Sheep wit' da Fishes", ingredients:
                    [.Cheese:1, .Cow:1, .Fish:2]),
                MenuItem(name: "Merchant of Venison", ingredients:
                    [.Vegetable:2, .Cow:2]),
                MenuItem(name: "Pope Clement IX", ingredients:
                    [.Sauce:1, .Vegetable:1, .Cheese:1, .Bird:2])]),
        MenuCategory(
            name: "Pizze Etc.",
            range: 4...5,
            menuItems: [
                MenuItem(name: "Primo", ingredients:
                    [.Bun:1, .Sauce:1, .Cheese:1]),
                MenuItem(name: "Excelsior", ingredients:
                    [.Bun:1, .Sauce:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Gladiator", ingredients:
                    [.Bun:1, .Sauce:1, .Bird:1, .Cow:1]),
                MenuItem(name: "Myrmidon", ingredients:
                    [.Bun:1, .Vegetable:1, .Cheese:1, .Fish:1]),
                MenuItem(name: "Maximus", ingredients:
                    [.Vegetable:1, .Cheese:1, .Bird:1, .Cow:1, .Fish:1]),
                MenuItem(name: "Godfather", ingredients:
                    [.Sauce:1, .Vegetable:1, .Bird:2, .Pie:1])]),
        MenuCategory(
            name: "Children's Menu",
            range: 6...6,
            menuItems: [
                MenuItem(name: "Penne For Your Tots", ingredients:
                    [.Bun:1, .Vegetable:1]),
                MenuItem(name: "Moolius Caesar", ingredients:
                    [.Bun:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Marc Antony", ingredients:
                    [.Bun:1, .Fish:1]),
                MenuItem(name: "Cleopatra", ingredients:
                    [.Bun:1, .Cheese:1, .Bird:1]),
                MenuItem(name: "Notisi Beingrini", ingredients:
                    [.Vegetable:1, .Cheese:1]),
                MenuItem(name: "Chocolate Mussolini", ingredients:
                    [.Sauce:1, .Pie:1])])],
    smallDeck: Deck(
        cardCounts: [.Bun:6, .Sauce:6, .Vegetable:6, .Cheese:6, .Cow:5, .Fish:4, .Bird:6, .Pie:3]),
    largeDeck: Deck(
        cardCounts: [.Bun:8, .Sauce:8, .Vegetable:9, .Cheese:8, .Cow:7, .Fish:6, .Bird:8, .Pie:4]),
    specialRule: "A dish is always worth the same number of points, no matter how many parts it is missing. Track the extra points with tokens."),
    
    Restaurant(
    image:      "Montezuma's Zombie",
    name:       "Montezuma's Mexi-Deli",
    subTitle:   "Ostensibly Food, Affordably Pricd",
    menuCategories: [
        MenuCategory(
            name: "Subz 'n Snax",
            range: 1...2,
            menuItems: [
                MenuItem(name: "Don Quixote", ingredients:
                    [.Bun:1]),
                MenuItem(name: "Sancho Panza", ingredients:
                    [.Vegetable:1]),
                MenuItem(name: "Mask of Zorro", ingredients:
                    [.Cheese:1]),
                MenuItem(name: "Salsa Kielbasa", ingredients:
                    [.Vegetable:1, .Cow:1]),
                MenuItem(name: "El Diablo", ingredients:
                    [.Bun:1, .Sauce:1, .Drink:1]),
                MenuItem(name: "Conquest of Paradise", ingredients:
                    [.Bird:3])]),
        MenuCategory(
            name: "Lunches",
            range: 3...4,
            menuItems: [
                MenuItem(name: "Rotten Burro", ingredients:
                    [.Cheese:1, .Cow:1, .Fish:1]),
                MenuItem(name: "Treasure of the Sierra Madre", ingredients:
                    [.Cheese:1, .Cow: 1, .Bird:1]),
                MenuItem(name: "Neato Fajito", ingredients:
                    [.Bun:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Gonzo Garbanzo", ingredients:
                    [.Vegetable:2, .Fish:1]),
                MenuItem(name: "Vito Carnito", ingredients:
                    [.Bun:1, .Sauce:1, .Cheese:1, .Cow:1]),
                MenuItem(name: "Juan Sanchez Ramirez Villa Lobos", ingredients:
                    [.Sauce:2, .Vegetable:2, .Cheese:1])]),
        MenuCategory(
            name: "Dinners",
            range: 5...5,
            menuItems: [
                MenuItem(name: "Chicken con Pollo", ingredients:
                    [.Sauce:1, .Drink:1, .Bird:2]),
                MenuItem(name: "Beef con Carne", ingredients:
                    [.Sauce:1, .Drink:1, .Cow:2]),
                MenuItem(name: "Surpriso del Mar", ingredients:
                    [.Sauce:1, .Vegetable:1, .Fish:2]),
                MenuItem(name: "Beef which is Actually Beef", ingredients:
                    [.Bun:1, .Sauce:1, .Vegetable:1, .Bird:1, .Fish:1]),
                MenuItem(name: "Quetzalcoatl", ingredients:
                    [.Bun:1, .Drink:1, .Cow:1, .Bird:1, .Fish:1]),
                MenuItem(name: "Huitzilopochtli", ingredients:
                    [.Bun:1, .Sauce:1, .Drink:1, .Vegetable:1, .Cheese:1, .Bird:1])]),
        MenuCategory(
            name: "Drinks",
            range: 6...6,
            menuItems: [
                MenuItem(name: "Rio Grind", ingredients:
                    [.Drink:1, .Vegetable:1]),
                MenuItem(name: "Banker's Holiday", ingredients:
                    [.Sauce:1, .Drink:1]),
                MenuItem(name: "Forget the Alamo", ingredients:
                    [.Drink:1, .Fish:1]),
                MenuItem(name: "Tequila Mockingbird", ingredients:
                    [.Sauce:1, .Drink:1, .Bird:1]),
                MenuItem(name: "Ponce de Leon", ingredients:
                    [.Sauce:1, .Vegetable:1, .Cheese:2]),
                MenuItem(name: "Secret Tijuana Deathmatch", ingredients:
                    [.Drink:2, .Bird:1, .Cow:1])])],
    smallDeck: Deck(
        cardCounts: [.Bun:4, .Sauce:6, .Drink:5, .Vegetable:6, .Cheese:6, .Cow:5, .Fish:4, .Bird:5, .Pie:1]),
    largeDeck: Deck(
        cardCounts: [.Bun:7, .Sauce:8, .Drink:7, .Vegetable:10, .Cheese:8, .Cow:8, .Fish:6, .Bird:9, .Pie:1]),
    specialRule: "You can substitute any meat card for the correct one, but it scores 0 points. It is impossible to play the pie."),
]
