//
//  Constants.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static let lightGreen: UIColor! = UIColor(colorLiteralRed: 111/255, green: 207/255, blue: 151/255, alpha: 1)
    static let darkGreen: UIColor! = UIColor(colorLiteralRed: 33/255, green: 150/255, blue: 83/255, alpha: 1)
    
    static let testRecipe1 = Recipe(recipeName: "Pasta", ingredients: ["Tomatoes", "Spaghetti"], imageUrl: "https://i.imgur.com/Xd4zQyR.jpg", recipeUrl: "http://www.kevinandamanda.com/cheeseburger-macaroni/")
    static let testRecipe2 = Recipe(recipeName: "Pizza", ingredients: ["Tomatoes", "Dough", "Cheese"], imageUrl: "https://i.imgur.com/VUEGlFp.jpg", recipeUrl: "https://imgur.com/gallery/hwq0z")
    static let testRecipeArray = [testRecipe1, testRecipe2]
    
    static let ingredient1: Ingredient = Ingredient(ingredientName: "Tomatoes", ingredientPhotoUrl: "https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg")
    static let ingredient2: Ingredient = Ingredient(ingredientName: "Potatoes", ingredientPhotoUrl: "http://i0.kym-cdn.com/photos/images/original/000/310/249/07c.jpg")
    static let ingredient3: Ingredient = Ingredient(ingredientName: "Parsley", ingredientPhotoUrl: "http://media.mercola.com/assets/images/foodfacts/parsley-nutrition-facts.jpg")
    static let ingredients: [Ingredient] = [ingredient1, ingredient2, ingredient3, ingredient1, ingredient2, ingredient3, ingredient1, ingredient2, ingredient3, ingredient1, ingredient2, ingredient3, ingredient1, ingredient2, ingredient3, ingredient1, ingredient2, ingredient3, ingredient1, ingredient2, ingredient3, ingredient1, ingredient2, ingredient3]
    
}
