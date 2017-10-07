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
}
