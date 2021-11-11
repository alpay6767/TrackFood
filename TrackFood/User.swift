//
//  Player.swift
//  CallOfInfo
//
//  Created by Alpay Kücük on 29.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class User {
    
    var id: String?
    var username: String?
    var password: String?
    var token: String?
    var firmenid: String?
    
    
    init(id: String, username: String, password: String, token: String, firmenid: String) {
        self.id = id
        self.username = username
        self.password = password
        self.token = token
        self.firmenid = firmenid
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.id = value!["id"] as? String
        self.username = value!["username"] as? String
        self.password = value!["password"] as? String
        self.token = value!["token"] as? String
        self.firmenid = value!["firmenid"] as? String
    }
    
    init() {
        
    }
    
    init(username: String) {
        self.username = username
    }
    
    func updatePassword(password: String) {
        self.password = password
        let ref = Database.database().reference()
        ref.child("Mitarbeiter").child((self.id)!).child("password").setValue(self.password)
        let fbhandler = FBHandler()
        fbhandler.saveUserToDefaults(user: self)
    }
    
}
