//
//  Person.swift
//  Snackii
//
//  Created by Makay Chapple on 3/27/19.
//  Copyright © 2019 Dallin Smuin. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: String? { get set }
}

protocol DocumentUserSerializable {
    init?(personDictionary: [String: Any])
}

struct Person {
    let name: String
    let email: String
    let password: String
    var admin: Bool = false
    var arrayOfSnacks: [Snack]
    let id: String
    
    var personDictionary: [String: Any] {
        return [
            
            "name": name,
            "email": email,
            "password": password,
            "admin": admin,
            "arrayOfSnacks": arrayOfSnacks,
            "id": id
        ]
    }
    
}

extension Person {
    init?(personDictionary: [String : Any]) {
        guard let name = personDictionary["name"] as? String,
            let email = personDictionary["email"] as? String,
            let password = personDictionary["password"] as? String,
            let admin = personDictionary["admin"] as? Bool,
            let arrayOfSnacks = personDictionary["arrayOfSnacks"] as? Snack,
            let id = personDictionary["id"] as? String else {return nil}
        self.init(name: name, email: email, password: password, admin: admin, arrayOfSnacks: [arrayOfSnacks], id: id)
    }
}


