//
//  RestrauntInfo.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
class RestaurantInfo {
    init() {
        
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
                cardCounts: [.Bun:11, .Sauce:6, .Fries:5, .Drink:9, .Vegetable:8, .Cheese:8, .Cow:7, .Fish:6, .Bird:7, .Pie:4]))]
}
