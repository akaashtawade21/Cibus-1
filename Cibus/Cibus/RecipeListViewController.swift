//
//  RecipeListViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var tableView: UITableView!
    var recipes: [Recipe]!
    var numCells: Int = 0
    var vc: UIViewController!
    
    var picker: UIImagePickerController = UIImagePickerController()
    
    var urlToPass: String!
    var titleToPass: String!
    
    var imageToPass: UIImage!
    var cameraIcon: UIImage = #imageLiteral(resourceName: "ic_camera_alt")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.parent?.navigationItem.hidesBackButton = true
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: cameraIcon, style: .plain, target: self, action: #selector(openPhotoSelectionViewController))
        
        // load the recipes from the database.
        // TODO: Make this a DB call.
        recipes = Constants.testRecipeArray
        Utils.getRecipesList(uid: "1") { (recipesList) in
            self.setRecipesList(newRecipes: recipesList)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .reload, object: nil)
    }
    
    func reloadTableData() {
        Utils.getRecipesList(uid: "1") { (recipesList) in
            self.setRecipesList(newRecipes: recipesList)
            self.tableView.reloadData()
        }
    }
    
    func setRecipesList(newRecipes: [Recipe]) {
        numCells = newRecipes.count
        self.recipes = newRecipes
        if (self.tableView == nil) {
            addTableView()
        } else {
            tableView.reloadData()
        }
    }
    
    func openPhotoSelectionViewController() {
        let alertController = UIAlertController(title: nil, message: "How would you like to select your photo?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let chooseFromPhotoRoll = UIAlertAction(title: "Choose From Photo Roll", style: .default) { action in
            self.picker.delegate = self
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        }
        
        alertController.addAction(chooseFromPhotoRoll)
        
        let takeNewPhoto = UIAlertAction(title: "Take New Photo", style: .default) { action in
            self.picker.delegate = self
            self.picker.allowsEditing = false
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)        }
        alertController.addAction(takeNewPhoto)
        
        self.present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageToPass = chosenImage
        dismiss(animated: true, completion: {
            self.performSegue(withIdentifier: "toPhotoSelectionVC", sender: self)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Recipes"
    }
    
    func addTableView() {
        tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 65, width: self.view.frame.width, height: self.view.frame.height - 60)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: "recipeCell")
        numCells = recipes.count
        view.addSubview(tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebViewVC" {
            vc = segue.destination as! RecipeWebViewController
            (vc as! RecipeWebViewController).recipeTitle = titleToPass
            (vc as! RecipeWebViewController).urlString = urlToPass
        } else if segue.identifier == "toPhotoSelectionVC" {
            vc = segue.destination as! PhotoSelectionViewController
            (vc as! PhotoSelectionViewController).photo = imageToPass
        }
    }
}

extension RecipeListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        urlToPass = (tableView.cellForRow(at: indexPath) as! RecipeTableViewCell).recipe.recipeUrl
        titleToPass = (tableView.cellForRow(at: indexPath) as! RecipeTableViewCell).recipe.recipeName
        performSegue(withIdentifier: "toWebViewVC", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.recipe = recipes[indexPath.row]
        cell.awakeFromNib()
        updateRecipeValuesAsynchronously(indexPath: indexPath, cell: cell)
        return cell
    }
    
    func updateRecipeValuesAsynchronously(indexPath: IndexPath, cell: RecipeTableViewCell) {
        // TODO: db call to get recipes, handle as follows
        cell.recipeNameLabel.text = cell.recipe.recipeName
        cell.recipeIngredientsTextView.text = "Ingredients: " + cell.recipe.ingredients.joined(separator: ", ")
        cell.recipeExpirationDateLabel.text = "Expires in \(cell.recipe.recipeExpiration!) days!"
        cell.recipeImageView.imageFromServerURL(urlString: cell.recipe.imageUrl)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCells
    }
}
