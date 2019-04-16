//
//  IntroViewController.swift
//  Snackii
//
//  Created by Dallin Smuin on 3/20/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth
import FirebaseFirestore


class IntroViewController: UIViewController {
    @IBAction func LoginButtonTapped(_ sender: Any) {
        // 1 getting authViewcontroller from FUIAuth.defaultAuthUI and storing it in authViewController
        if let authViewController = FUIAuth.defaultAuthUI()?.authViewController() {
            
            // 2 shows the authViewController to user
            show(authViewController, sender: sender)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let handle = Auth.auth().addStateDidChangeListener({ (Auth, User) in
            // do something
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}

