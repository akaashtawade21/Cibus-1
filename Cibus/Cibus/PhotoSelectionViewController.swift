//
//  PhotoSelectionViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class PhotoSelectionViewController: UIViewController {

    var photo: UIImage!
    var imgView: UIImageView!
    
    var receiptButton: UIButton!
    var ingredientButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photo Selection"
        self.addImageView()
        self.addButtons()
    }
    
    func addImageView() {
        imgView = UIImageView()
        imgView.frame = CGRect(
            x: 0.1 * self.view.frame.width,
            y: 65 +  0.1 * self.view.frame.width,
            width: 0.8 * self.view.frame.width,
            height: 1.25 * self.view.frame.width
        )
        imgView.image = photo
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        view.addSubview(imgView) 
    }
    
    func addButtons() {
        addReceiptButton()
        addIngredientButton()
    }
    
    func addReceiptButton() {
        receiptButton = UIButton()
        receiptButton.frame = CGRect(
            x: self.view.center.x - 0.4*view.frame.width,
            y: self.view.frame.height - 80,
            width: 0.4 * view.frame.width - 5,
            height: 40
        )
        receiptButton.setTitle("receipt", for: .normal)
        receiptButton.setTitleColor(UIColor.white, for: .normal)
        receiptButton.layer.cornerRadius = 16
        receiptButton.backgroundColor = Constants.darkGreen
        receiptButton.contentHorizontalAlignment = .center
        receiptButton.addTarget(self, action: #selector(handleReceiptProcessing), for: .touchUpInside)
        self.view.addSubview(receiptButton)
    }
    
    //TODO: implement
    func handleReceiptProcessing() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addIngredientButton() {
        ingredientButton = UIButton()
        ingredientButton.frame = CGRect(
            x: self.view.center.x + 5,
            y: self.view.frame.height - 80,
            width: 0.4 * view.frame.width - 5,
            height: 40
        )
        ingredientButton.setTitle("ingredient", for: .normal)
        ingredientButton.setTitleColor(UIColor.white, for: .normal)
        ingredientButton.layer.cornerRadius = 16
        ingredientButton.backgroundColor = Constants.darkGreen
        ingredientButton.contentHorizontalAlignment = .center
        ingredientButton.addTarget(self, action: #selector(handleIngredientProcessing), for: .touchUpInside)
        self.view.addSubview(ingredientButton)
    }
    
    // TODO: Implement
    func handleIngredientProcessing() {
        self.navigationController?.popViewController(animated: true)
    }
}
