//
//  IngredientListViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit
import Alamofire

//TODO: Make a loading screen at some point. 

class IngredientListViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var cameraIcon: UIImage = #imageLiteral(resourceName: "ic_camera_alt")
    var ingredients: [Ingredient]!
    var tableView: UITableView!
    var numCells: Int!
    var imageToPass: UIImage!
    var picker: UIImagePickerController = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parent?.navigationItem.hidesBackButton = true
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: cameraIcon, style: .plain, target: self, action: #selector(openPhotoSelectionViewController))
        //TODO: Load this from the database
        // ingredients = Constants.ingredients
        
        // this sets up the table view as well.
        Utils.getIngredientsList(uid: "1") { (ingredientsList) in
            self.setIngredientsList(newIngredients: ingredientsList)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData), name: .reload, object: nil)
    }
    
    func reloadTableData() {
        Utils.getIngredientsList(uid: "1") { (ingredientsList) in
            self.setIngredientsList(newIngredients: ingredientsList)
            self.tableView.reloadData()
        }
    }
    
    func setIngredientsList(newIngredients: [Ingredient]) {
        numCells = newIngredients.count
        self.ingredients = newIngredients
        if (self.tableView == nil) {
            setupTableView()
        } else {
            tableView.reloadData()
        }
    }

    func getLargestNumberOfExpirationDays() -> Int {
        return ingredients[ingredients.count - 1].expirationDays!
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelectionVC" {
            let vc = segue.destination as! PhotoSelectionViewController
            vc.photo = imageToPass
        }
    }
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
