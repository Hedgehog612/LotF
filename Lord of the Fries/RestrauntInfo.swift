//
//  RestrauntInfo.swift
//  Lord of the Fries
//
//  Created by Marcus Bamberger on 10/18/19.
//  Copyright © 2019 Marcus Bamberger. All rights reserved.
//

import Foundation
var restrauntList = [
    Restaurant(
        image: "Ratherbee's Zombie",
        name: "Ratherbee's Steakhouse",
        subTitle: "Home of the Mighty Cholesterol Onion",
        menuCategories: [
            MenuCategory(
                name: "Appetizers",
                range: 1...2, menuItems: [
                    MenuItem(name: "Donner Pass", cardItems: [:]),
                    MenuItem(name: "Clam Before the Storm", cardItems: [.Fish:1]),
                    MenuItem(name: "Mighty Cholesterol Onion", cardItems: [.Vegetable:1]),
                    MenuItem(name: "Triple Thick Milkshake", cardItems: [.Drink:1, .Cheese:1]),
                    MenuItem(name: "Paul Bunion", cardItems: [.Fries:1, .Vegetable:1, .Cheese:1]),
                    MenuItem(name: "Patriotic Chicken Vegetable Medley", cardItems: [.Vegetable:1, .Bird:1])]),
            MenuCategory(
                name: "Burgers",
                range: 3...4, menuItems: [
                    MenuItem(name: "Amazing Meatless Burger", cardItems: [.Bun:1]),
                    MenuItem(name: "Super Amazing Meatless Burger", cardItems: [.Bun:2]),
                    MenuItem(name: "Bum Steer", cardItems: [.Bun:1, .Bird:1]),
                    MenuItem(name: "Fur Piece", cardItems: [.Bun:1, .Cow:1, .Pie:1]),
                    MenuItem(name: "Fishabunga", cardItems: [.Bun:1, .Cheese:1, .Fish:1]),
                    MenuItem(name: "Claim Jumper", cardItems: [.Bun:1, .Sauce:1, .Fries:1, .Vegetable:1, .Cheese:1, .Bird:1, .Cow:1])]),
            MenuCategory(
                name: "Fat Meal Deals",
                range: 5...5,
                menuItems: [
                    MenuItem(name: "Salmon Rushdie", cardItems: [.Sauce:1, .Vegetable:1, .Cheese:1, .Fish:1]),
                    MenuItem(name: "Manifest Destiny", cardItems: [.Sauce:1, .Drink:1, .Cheese:1, .Bird:1]),
                    MenuItem(name: "Intestinal Fortitude", cardItems: [.Sauce:1, .Bird:1, .Cow:1, .Fish:1]),
                    MenuItem(name: "Pretty Good Corral", cardItems: [.Drink:1, .Vegetable:1, .Cow:2, .Pie:1]),
                    MenuItem(name: "We'll Fry Anything!", cardItems: [.Bun:1, .Fries:1, .Drink:1, .Vegetable:1, .Cheese:1, .Pie:1]),
                    MenuItem(name: "Bovine Recombinant Yum, Yum, Yum!", cardItems: [.Bun:2, .Drink:2, .Cheese:1, .Cow:1])]),
            MenuCategory(
                name: "Drinks",
                range: 6...6,
                menuItems: [
                    MenuItem(name: "Covered Wagon", cardItems: [.Drink:1]),
                    MenuItem(name: "Blindfolded Pioneer", cardItems: [.Drink:1, .Pie:1]),
                    MenuItem(name: "Aertery Blocker", cardItems: [.Sauce:1, .Fries:1, .Drink:1, .Cheese:1]),
                    MenuItem(name: "Heart Pounder", cardItems: [.Sauce:1, .Drink:1, .Cow:1]),
                    MenuItem(name: "Synaptic Relay Deteriorator", cardItems: [.Drink:1, .Bird:1, .Fish:1]),
                    MenuItem(name: "Lying Dead On the Floor", cardItems: [.Sauce:1, .Drink:1, .Bird:1, .Cow:1, .Fish:1])])])]
