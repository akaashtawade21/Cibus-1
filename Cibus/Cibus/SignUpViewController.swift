//
//  SignUpViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // UI
    let mdbSocialsLogo: UIImage = #imageLiteral(resourceName: "cibus-white")
    var logoImageView: UIImageView!
    var backgroundColor: UIColor = Constants.lightGreen
    
    
    var fullNameTextField: TextField!
    var emailTextField: TextField!
    var usernameTextField: TextField!
    var passwordOneTextField: TextField!
    var passwordTwoTextField: TextField!
    
    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // addTextFieldContainer()
        // if you have time (you won't)
        self.view.backgroundColor = self.backgroundColor
        self.title = "Sign Up"
        addMDBSocialsLogo()
        addSubmitButton()
        addTextFields()
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
    
    func addTextFields() {
        addPasswordTwoTextField()
        addPasswordOneTextField()
        addUsernameTextField()
//        addEmailTextField()
//        addFullNameTextField()
    }
    
    func addFullNameTextField() {
        fullNameTextField = TextField()
        fullNameTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: emailTextField.frame.minY - 60,
            width: 0.8 * view.frame.width,
            height: 40
        )
        fullNameTextField.backgroundColor = UIColor.white
        fullNameTextField.layer.cornerRadius = 16
        fullNameTextField.placeholder = "full name"
        fullNameTextField.autocorrectionType = .no
        fullNameTextField.autocapitalizationType = .none
        view.addSubview(fullNameTextField)
    }
    
    func addEmailTextField() {
        emailTextField = TextField()
        emailTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: usernameTextField.frame.minY - 60,
            width: 0.8 * view.frame.width,
            height: 40
        )
        emailTextField.backgroundColor = UIColor.white
        emailTextField.layer.cornerRadius = 16
        emailTextField.placeholder = "email"
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        view.addSubview(emailTextField)
    }
    
    func addUsernameTextField() {
        usernameTextField = TextField()
        usernameTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: passwordOneTextField.frame.minY - 60,
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
    
    func addPasswordOneTextField() {
        passwordOneTextField = TextField()
        passwordOneTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: passwordTwoTextField.frame.minY - 60,
            width: 0.8 * view.frame.width,
            height: 40
        )
        passwordOneTextField.backgroundColor = UIColor.white
        passwordOneTextField.layer.cornerRadius = 16
        passwordOneTextField.placeholder = "password"
        passwordOneTextField.autocorrectionType = .no
        passwordOneTextField.autocapitalizationType = .none
        passwordOneTextField.isSecureTextEntry = true
        
        view.addSubview(passwordOneTextField)
    }
    func addPasswordTwoTextField() {
        passwordTwoTextField = TextField()
        passwordTwoTextField.frame = CGRect(
            x: 0.1 * view.frame.width,
            y: submitButton.frame.minY - 60,
            width: 0.8 * view.frame.width,
            height: 40
        )
        passwordTwoTextField.backgroundColor = UIColor.white
        passwordTwoTextField.layer.cornerRadius = 16
        passwordTwoTextField.placeholder = "retype password"
        passwordTwoTextField.autocorrectionType = .no
        passwordTwoTextField.autocapitalizationType = .none
        passwordTwoTextField.isSecureTextEntry = true
        
        view.addSubview(passwordTwoTextField)
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
        submitButton.addTarget(self, action: #selector(verifySignupInformation), for: .touchUpInside)
        self.view.addSubview(submitButton)
    }
    
    // on submit, check:
    // 1. if the username is taken
    // 2. if the passwords match
    // 3. if the email already has an associated account
    // 4.
    func verifySignupInformation() {
        // if passwords don't match, add an alert
        if (passwordOneTextField.text != passwordTwoTextField.text) {
            let alertController = UIAlertController(title: "Error", message:
                "Your two passwords do not match.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: clearPasswords)
            return
            // else if fields are empty, add an alert
        } else if (fieldsAreEmpty()) {
            let alertController = UIAlertController(title: "Error", message:
                "You still have some empty fields!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: clearPasswords)
            return
        }
        
        // TODO 1: Actually do a login!!!!
        performSegue(withIdentifier: "fromSignupVCToRecipeListVC", sender: self)
    }
    
    func clearEmail() {
        emailTextField.text = ""
    }
    
    func clearPasswords() {
        passwordOneTextField.text = ""
        passwordTwoTextField.text = ""
    }
    
    func clearUserAndPass() {
        clearPasswords()
        usernameTextField.text = ""
    }
    
    func fieldsAreEmpty() -> Bool {
        return (usernameTextField.text == "") || (passwordOneTextField.text == "") || (passwordTwoTextField.text == "")
    }
    
    
    
}
