//
//  SignUpViewController.swift
//  Snackii
//
//  Created by Hayden Hoki on 4/30/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    static let SignInPath = SignUpViewController()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterTextField: UITextField!
    @IBOutlet weak var adminSwitch: UISwitch!
    var displayName = ""
    var email = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        checkDisplayName()
        checkEmail()
        checkPassword()
        checkEverythingWasChanged(displayName: displayName, email: email, password: password)
    }
    
    // MARK: - Functions
    func checkDisplayName() {
        if nameTextField.text != "" {
            guard let displayNameText = nameTextField.text else { return }
            self.displayName = displayNameText
        }
    }
    
    func checkEmail() {
        if emailTextField.text != "" {
            guard let emailText = emailTextField.text else { return }
            self.email = emailText
        }
    }
    
    func checkPassword() {
        let password = passwordTextField.text
        let reenteredPassword = reenterTextField.text
        if password != "" && password == reenteredPassword {
            guard let passwordText = password else { return }
            self.password = passwordText
        }
    }

    func checkEverythingWasChanged(displayName: String, email: String, password: String) {
        var adminRights: Bool
        if adminSwitch.isEnabled {
            adminRights = true
        } else {
            adminRights = false
        }
        
        if displayName != "" && email != "" && password != "" {
            var man = Person.init(name: displayName, email: email, password: password, admin: adminRights)
            print(man)
            performSegue(withIdentifier: "DataIsFilled", sender: self)
        } else {
            self.displayName = ""
            self.email = ""
            self.password = ""
        }
    }
    
    
}
