//
//  Ingredient.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import Foundation
import UIKit

class Ingredient : NSObject {
    var ingredientName: String!
    var ingredientPhotoUrl: String?
    var ingredientImage: UIImage?
    var expirationDays: Int?
    
    init(ingredientName: String) {
        self.ingredientName = ingredientName.capitalizingFirstLetter()
    }
    
    init(ingredientName: String, ingredientPhotoUrl: String) {
        self.ingredientName = ingredientName.capitalizingFirstLetter()
        self.ingredientPhotoUrl = ingredientPhotoUrl
    }
    
    
    init(ingredientName: String, ingredientPhotoUrl: String, expirationDays: Int) {
        self.ingredientName = ingredientName.capitalizingFirstLetter()
        self.ingredientPhotoUrl = ingredientPhotoUrl
        self.expirationDays = expirationDays
    }
    
    init (ingredientJson: [String:Any]) {
        self.ingredientName = ingredientJson["ingredient_name"] as! String
        self.ingredientPhotoUrl = (ingredientJson["ingredient_photo_url"] as! String).capitalizingFirstLetter()
    }
}

