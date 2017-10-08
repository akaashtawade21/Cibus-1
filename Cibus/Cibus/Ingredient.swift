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
    
    init(ingredientName: String) {
        self.ingredientName = ingredientName
    }
    
    init(ingredientName: String, ingredientPhotoUrl: String) {
        self.ingredientName = ingredientName
        self.ingredientPhotoUrl = ingredientPhotoUrl
    }
    
    init (ingredientJson: [String:Any]) {
        self.ingredientName = ingredientJson["ingredient_name"] as! String
        self.ingredientPhotoUrl = ingredientJson["ingredient_photo_url"] as! String
    }
}

