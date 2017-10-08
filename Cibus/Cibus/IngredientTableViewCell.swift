//
//  IngredientTableViewCell.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    var ingredientImage: UIImage!
    var ingredientImageView: UIImageView!
    var ingredientNameLabel: UILabel!
    var ingredient: Ingredient!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupIngredientImageView()
        setupIngredientNameLabel()
    }
    
    func setupIngredientImageView() {
        ingredientImageView = UIImageView()
        ingredientImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: contentView.frame.height - 10,
            height: contentView.frame.height - 10
        )
        ingredientImageView.image = #imageLiteral(resourceName: "default-landscape")
        ingredientImageView.clipsToBounds = true
        ingredientImageView.contentMode = .scaleAspectFill
        contentView.addSubview(ingredientImageView)
    }
    
    func setupIngredientNameLabel() {
        
        ingredientNameLabel = UILabel()
        ingredientNameLabel.frame = CGRect(
            x: ingredientImageView.frame.maxX + 10,
            y: ingredientImageView.frame.minY + 50,
            width: 250,
            height: 36
        )
        ingredientNameLabel.font = UIFont(name: "Helvetica Neue", size: 26)
        ingredientNameLabel.textAlignment = .left
        ingredientNameLabel.text = ingredient.ingredientName
        contentView.addSubview(ingredientNameLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
