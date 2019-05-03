//
//  LoginViewController.swift
//  Snackii
//
//  Created by Hayden Hoki on 4/30/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    let email = "bob@bobmail.com"
    let password = "bob"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if emailLoginTextField.text == email && passwordLoginTextField.text == password {
            performSegue(withIdentifier: "Login", sender: self)
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: self)
    }
    
}
