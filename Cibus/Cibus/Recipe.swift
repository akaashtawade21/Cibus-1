//
//  Recipe.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import Foundation

class Recipe {
    var recipeName: String!
    var ingredients: [String]!
    var imageUrl: String!
    var recipeUrl: String!
    var recipeExpiration: Int!
    
    init(recipeName: String, ingredients: [String], imageUrl: String, recipeUrl: String) {
        self.recipeName = recipeName
        self.ingredients = ingredients
        self.imageUrl = imageUrl
        self.recipeUrl = recipeUrl
    }
    
    // create one for string and one for data
    init(json: [String:Any]) {
        self.recipeName = json["recipe_name"] as! String
        self.ingredients = json["ingredients"] as! [String]
        self.imageUrl = json["image_url"] as! String
        self.recipeUrl = json["recipe_url"] as! String
        self.recipeExpiration = json["recipe_expiration"] as! Int
    }
    
    
}
