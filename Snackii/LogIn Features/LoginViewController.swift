//
//  LoginViewController.swift
//  Snackii
//
//  Created by Hayden Hoki on 4/30/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        #if DEBUG
        emailLoginTextField.text = "test3@test.com"
        passwordLoginTextField.text = "password"
        #endif
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailLoginTextField.text else {return}
        guard let password = passwordLoginTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "Login", sender: self)
            } else {
                let alert = UIAlertController(title: "Error Logging In", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "SignUp", sender: self)
    }
    
}
