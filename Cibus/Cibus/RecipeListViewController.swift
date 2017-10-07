//
//  RecipeListViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {
    
    var tableView: UITableView!
    var recipes: [Recipe]!
    var numCells: Int = 0
    
    var urlToPass: String!
    var titleToPass: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.parent?.navigationItem.hidesBackButton = true
        
        // load the recipes from the database.
        // TODO: Make this a DB call.
        recipes = Constants.testRecipeArray
        
        addTableView()
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
            let vc = segue.destination as! RecipeWebViewController
            vc.recipeTitle = titleToPass
            vc.urlString = urlToPass
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
        cell.recipeIngredientsTextView.text = String(describing: cell.recipe.ingredients)
        cell.recipeImageView.imageFromServerURL(urlString: cell.recipe.imageUrl)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCells
    }
}
