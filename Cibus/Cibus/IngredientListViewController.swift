//
//  IngredientListViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class IngredientListViewController: UIViewController {

    var cameraIcon: UIImage = #imageLiteral(resourceName: "ic_camera_alt")
    var ingredients: [Ingredient]!
    var tableView: UITableView!
    var numCells: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parent?.navigationItem.hidesBackButton = true
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: cameraIcon, style: .plain, target: self, action: #selector(openPhotoSelectionViewController))
        //TODO: Load this from the database
        ingredients = Constants.ingredients
        self.setupTableView()
    }

    func setupTableView() {
        tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 65, width: self.view.frame.width, height: self.view.frame.height - 60)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IngredientTableViewCell.self, forCellReuseIdentifier: "ingredientCell")
        numCells = ingredients.count
        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.title = "Ingredient List"
    }
    
    func openPhotoSelectionViewController() {
        performSegue(withIdentifier: "toPhotoSelectionVC", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension IngredientListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.ingredient = ingredients[indexPath.row]
        cell.awakeFromNib()
        updateIngredientValuesAsynchronously(indexPath: indexPath, cell: cell)
        return cell
    }
    
    
    func updateIngredientValuesAsynchronously(indexPath: IndexPath, cell: IngredientTableViewCell) {
        // TODO: db call to get recipes, handle as follows
        cell.ingredientNameLabel.text = cell.ingredient.ingredientName
        // get the image and reload the cell once.
        cell.ingredientImageView.imageFromServerURL(urlString: cell.ingredient.ingredientPhotoUrl!)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numCells
    }
}
