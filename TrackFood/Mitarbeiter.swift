//
//  Mitarbeiter.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Mitarbeiter {
    
    var id: String?
    var vorname: String?
    var nachname: String?
    var mitarbeitercode: String?
    
    init(id: String, vorname: String, nachname: String, mitarbeitercode: String) {
        self.id = id
        self.vorname = vorname
        self.nachname = nachname
        self.mitarbeitercode = mitarbeitercode
    }
    
    init(mitarbeitercode: String) {
           self.mitarbeitercode = mitarbeitercode
    }
       
    init() {
           
    }
       
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.vorname = value!["vorname"] as? String
        self.id = value!["id"] as? String
        self.nachname = value!["nachname"] as? String
        self.mitarbeitercode = (value!["mitarbeitercode"] as? String)!
    }
       
    static func Anmelden(mitarbeitercode: String) -> Mitarbeiter {
           
        var ref: DatabaseReference!
        let foundPerson = Mitarbeiter(mitarbeitercode: "notfound")
         
        ref = Database.database().reference()
        ref.child("Mitarbeiter").observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Mitarbeiter(snapshot: snapshot) {
                    if card.mitarbeitercode == mitarbeitercode {
                    foundPerson.id = card.id
                    foundPerson.vorname = card.vorname
                    foundPerson.nachname = card.nachname
                    foundPerson.mitarbeitercode = card.mitarbeitercode
                    break
                    }
                }
            }
        }
        return foundPerson
    }
       
    static func Finden(mitarbeitercode: String) -> Bool {
        
        var ref: DatabaseReference!
        var gefunden = Bool()
    
        ref = Database.database().reference()
        ref.child("Mitarbeiter").observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Mitarbeiter(snapshot: snapshot) {
                    if card.mitarbeitercode == mitarbeitercode {
                        gefunden = true
                        break
                    }
                }
            }
        }
        return gefunden
    }
       
    
}
