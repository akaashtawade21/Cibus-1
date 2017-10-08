//
//  RecipeTableViewCell.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    var recipe: Recipe!
    
    var recipeImageView: UIImageView!
    var recipeNameLabel: UILabel!
    var recipeIngredientsTextView: UITextView!
    var recipeExpirationDateLabel: UILabel!
    
    var recipeImage: UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
        setupRecipeNameLabel()
        setupRecipeIngredientsTextView()
        setupRecipeExpirationDateLabel()
    }
    
    
    func setupImageView() {
        recipeImageView = UIImageView()
        recipeImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: contentView.frame.height - 10,
            height: contentView.frame.height - 10
        )
        recipeImageView.image = #imageLiteral(resourceName: "default-landscape")
        recipeImageView.clipsToBounds = true
        recipeImageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(recipeImageView)
    }
    
    func setupRecipeNameLabel() {
        recipeNameLabel = UILabel()
        recipeNameLabel.frame = CGRect(
            x: recipeImageView.frame.maxX + 10,
            y: recipeImageView.frame.minY + 20,
            width: 250,
            height: 36
        )
        recipeNameLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        recipeNameLabel.textAlignment = .left
        recipeNameLabel.text = "Default Event Name"
        contentView.addSubview(recipeNameLabel)
    }
    
    func setupRecipeIngredientsTextView() {
        recipeIngredientsTextView = UITextView()
        recipeIngredientsTextView.frame = CGRect(
            x: recipeNameLabel.frame.minX - 2,
            y: recipeNameLabel.frame.maxY + 10,
            width: 250,
            height: 30
        )
        recipeIngredientsTextView.font = UIFont(name: "Helvetica Neue", size: 14)
        recipeIngredientsTextView.textColor = UIColor.lightGray
        recipeIngredientsTextView.textAlignment = .left
        recipeIngredientsTextView.text = "Ingredients: [Ingredients]"
        recipeIngredientsTextView.textContainer.maximumNumberOfLines = 2
        recipeIngredientsTextView.textContainer.lineBreakMode = .byTruncatingTail
        recipeIngredientsTextView.isEditable = false
        contentView.addSubview(recipeIngredientsTextView)
    }
    
    func setupRecipeExpirationDateLabel() {
        recipeExpirationDateLabel = UILabel()
        recipeExpirationDateLabel.frame = CGRect(
            x: recipeNameLabel.frame.minX + 2,
            y: recipeIngredientsTextView.frame.maxY + 10,
            width: 250,
            height: 36
        )
        recipeExpirationDateLabel.font = UIFont(name: "Helvetica Neue", size: 16)
        recipeExpirationDateLabel.textAlignment = .left
        recipeExpirationDateLabel.text = "Expires in (x) Days"
        contentView.addSubview(recipeExpirationDateLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
