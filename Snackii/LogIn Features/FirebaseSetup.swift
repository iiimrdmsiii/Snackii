//
//  FirebaseSetup.swift
//  Snackii
//
//  Created by Makay Chapple on 4/9/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth

class FirebaseSetup: NSObject {
    func setupFirebase() {
        // 1 Configure Firebase
        FirebaseApp.configure()
        
        // 2 Set the current instance of FirebaseSetup as the delegate of defaultAuthUI.
        FUIAuth.defaultAuthUI()?.delegate = self
        
        // 3 Set defaultAuthUI providers as just GoogleAuth for now.
        FUIAuth.defaultAuthUI()?.providers = [FUIGoogleAuth()]
    }
    
    func handleOpenURL(url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        // 1 Retrieving a string from options that represents the source application
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        
        // 2 Call handleOpen on defaultAuthUI and return the result and if defaultAuthUI doesn't exist return false.
        return FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false
    }
}

// MARK: - FUIAuthDelegate Implementation
extension FirebaseSetup: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // print results and segue into vending controller
        print(authDataResult)
        if authDataResult != nil {
            let nextStoryBoard = UIStoryboard(name: "VendingSnacks", bundle: nil)
            let nextViewController = nextStoryBoard.instantiateViewController(withIdentifier: "Vending") 
            let appDelagate = UIApplication.shared.delegate as! AppDelegate
            appDelagate.window?.rootViewController = nextViewController
        }
    }
}
