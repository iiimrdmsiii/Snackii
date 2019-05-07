//
//  SignUpViewController.swift
//  Snackii
//
//  Created by Hayden Hoki on 4/30/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    static let SignInPath = SignUpViewController()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenterTextField: UITextField!
    @IBOutlet var adminSwitch: UISwitch!
    
    var displayName = ""
    var email = ""
    var password = ""
    
    var db: Firestore!
    var userId: String = ""
    var emailField: String = ""
    var passwordField: String = ""
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var username: String = ""
    let userDefault = UserDefaults.standard
    var currentAuthID = Auth.auth().currentUser?.uid
    var currentUser: User?
    var adminIsTrue: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         db = Firestore.firestore()
    }
    
    func createUser() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil ||
                self.emailTextField.text == "" ||
                self.passwordTextField.text == "" ||
                self.nameTextField.text == "" ||
                self.reenterTextField.text == "" ||
                self.reenterTextField.text != self.passwordTextField.text {
                UIView.animate(withDuration: 0.09, animations: {
                    let move = CGAffineTransform(translationX: 10, y: 0)
                    self.emailTextField.transform = move
                    self.passwordTextField.transform = move
                    self.nameTextField.transform = move
                    self.reenterTextField.transform = move
                }) { (_) in
                    UIView.animate(withDuration: 0.09, animations: {
                        self.emailTextField.transform = .identity
                        self.passwordTextField.transform = .identity
                        self.nameTextField.transform = .identity
                        self.reenterTextField.transform = .identity
                    })
                }
                print("Not Valid")
                print(error)
            } else {
                self.performSegue(withIdentifier: "DataIsFilled", sender: nil)
                print("UserID: \(self.currentAuthID ?? "your UID")")
            }
        }
    }
    
    func createData() {
        guard let id: String = self.currentAuthID else { return } //this not working.
        print(id)
        guard let name: String = nameTextField.text  else { return }
        print(name)
        guard let email: String = emailTextField.text  else { return }
        print(email)
        guard let password: String = passwordTextField.text  else { return }
        print(password)
        let admin: Bool =  adminIsTrue
        print(admin)
        let arrayOfSnacks: [Snack] = []
        print(arrayOfSnacks)
        
        let person = Person(name: name,
                            email: email,
                            password: password,
                            admin: admin,
                            arrayOfSnacks: arrayOfSnacks,
                            id: id)
        
        let userRef = self.db.collection("login")
        userRef.document(String(person.id)).setData(person.personDictionary){ error in
            if error == nil {
                print("Added User Data")
                print("call, UserID: \(self.currentAuthID)")
            } else {
                print("you have an error in creating data")
                print(Error.self)
            }
        }
    }
    
    @IBAction func logOutTapped(_ sender: Any) { //this isnt working correctly
        self.currentAuthID = nil
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("User Signed Out")
            print(currentAuthID ?? "No Current UID Detected")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        
        createUser()
        createData()
        print(currentAuthID)
        
    }
    
    @IBAction func adminSwitchTapped(_ sender: UISwitch) {
        
        if (sender.isOn == true) {
            
            adminIsTrue = true
            print("is admin")
        } else {
            
            adminIsTrue = false
            print("not admin")
        }
    }
    
    
    
    
}
