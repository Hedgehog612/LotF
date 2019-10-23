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
class Restaurant {
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
}


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
                MenuItem(name: "Donner Pass", ingredients: [:]),
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
    specialRule: "Yes, the Donner Pass is nothing. If it's the order, the leader passes to the left. No, you can't get rid of the Pie."),

    Restaurant(
    image:      "Friedey's Holiday Zombie",
    name:       "Friedey's Holiday Menu",
    subTitle:   "Friedey's Celebrates the Festival of the Season",
    menuCategories: [
        MenuCategory(
            name: "Stuffers",
            range: 1...2,
            menuItems: [
                MenuItem(name: "David Copperfield", ingredients: [.Cheese:1]),
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
                MenuItem(name: "Small Fry", ingredients: [.Fries:1]),
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
    specialRule: "The last category on the menu is Special Orders, which add ingredients to regular orders. Special Orders can only be rolled, not called.")]
