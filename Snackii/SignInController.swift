//
//  SignInController.swift
//  Snackii
//
//  Created by Makay Chapple on 4/15/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth


class SignInController {
    let signIn = Auth.auth().createUser(withEmail: Person.email, password: Person.password) { (AuthDataResult?, Error?, in
    
    })
}
