//
//  LoginViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let mdbSocialsLogo: UIImage = #imageLiteral(resourceName: "mdb_socials_logo_white-3")
    var logoImageView: UIImageView!
    var backgroundColor: UIColor = Constants.lightGreen
    var usernameTextField: TextField!
    var passwordTextField: TextField!
    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.backgroundColor
        self.title = "Login"
        addMDBSocialsLogo()
        addSubmitButton()
        addPasswordTextField()
        addUsernameTextField()
    }
    
    func addMDBSocialsLogo() {
        logoImageView = UIImageView()
        logoImageView.frame = CGRect(
            x: 0,
            y: 0.1 * view.frame.height,
            width: view.frame.width,
            height: 0.3 * view.frame.height
        )
        logoImageView.image = mdbSocialsLogo
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
    }
    
    func addUsernameTextField() {
        usernameTextField = TextField()
        usernameTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: passwordTextField.frame.minY - 60,
            width: 0.8 * view.frame.width,
            height: 40
        )
        usernameTextField.backgroundColor = UIColor.white
        usernameTextField.layer.cornerRadius = 16
        usernameTextField.placeholder = "username"
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        view.addSubview(usernameTextField)
    }
    
    func addPasswordTextField() {
        passwordTextField = TextField()
        passwordTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: submitButton.frame.minY - 60,
            width: 0.8 * view.frame.width,
            height: 40
        )
        passwordTextField.backgroundColor = UIColor.white
        passwordTextField.layer.cornerRadius = 16
        passwordTextField.placeholder = "password"
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        view.addSubview(passwordTextField)
    }
    
    func addSubmitButton() {
        submitButton = UIButton()
        submitButton.frame = CGRect(
            x: self.view.center.x - 0.4*view.frame.width,
            y: self.view.frame.height - 80,
            width: 0.8 * view.frame.width,
            height: 40
        )
        submitButton.setTitle("submit", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.layer.cornerRadius = 16
        submitButton.backgroundColor = Constants.darkGreen
        submitButton.contentHorizontalAlignment = .center
        submitButton.addTarget(self, action: #selector(verifyLoginInformation), for: .touchUpInside)
        self.view.addSubview(submitButton)
    }
    
    func verifyLoginInformation() {
        // TODO: Verify login information in firebase.
        if (someFieldsAreEmpty()) {
            let alertController = UIAlertController(title: "Error", message:
                "You still have some empty fields!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        
        //TODO: Actually do the login!!!
        performSegue(withIdentifier: "fromLoginVCToRecipeListVC", sender: self)

    }
    
    func someFieldsAreEmpty() -> Bool {
        return usernameTextField.text! == "" || passwordTextField.text! == ""
    }
    
    func clear() {
        usernameTextField.text = ""
        passwordTextField.text = ""
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
