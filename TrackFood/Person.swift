//
//  Person.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 21.03.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Person {
    
    var id: String?
    var covidcode: String?
    var name: String?
    var city: String?
    var email: String?
    var fragen = [Bool]()
    var frage1: Bool?
    var frage2: Bool?
    var frage3: Bool?
    var isEntranceChecker: Bool?
    var anzahlKlopapierGekauft: Int?
    
    
    init(id: String, covidcode: String, name: String, city: String, email: String) {
        self.id = id
        self.covidcode = covidcode
        self.name = name
        self.city = city
        self.email = email
    }
    
    init(covidcode: String) {
        self.covidcode = covidcode
    }
    
    init() {
        
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.name = value!["name"] as? String
        self.id = value!["id"] as? String
        self.email = value!["email"] as? String
        self.covidcode = (value!["covidcode"] as? String)!
        self.city = value!["city"] as? String
        self.frage1 = value!["frage1"] as? Bool
        self.frage2 = value!["frage2"] as? Bool
        self.frage3 = value!["frage3"] as? Bool
        self.isEntranceChecker = value!["isEntranceChecker"] as? Bool
        self.anzahlKlopapierGekauft = value!["anzahlKlopapierGekauft"] as? Int
    }
    
    
    
    
    static func Anmelden(covidcode: String) -> Person {
        
      var ref: DatabaseReference!
        let foundPerson = Person(covidcode: "notfound")
      
      ref = Database.database().reference()
      ref.child("User").observeSingleEvent(of: .value) { snapshot in
          for child in snapshot.children {
              if let snapshot = child as? DataSnapshot,
                  let card = Person(snapshot: snapshot) {
                  if card.covidcode == covidcode {
                    foundPerson.id = card.id
                    foundPerson.name = card.name
                    foundPerson.email = card.email
                    foundPerson.covidcode = card.covidcode
                    foundPerson.city = card.city
                    foundPerson.frage1 = card.frage1
                    foundPerson.frage2 = card.frage2
                    foundPerson.frage3 = card.frage3
                    foundPerson.fragen.append(foundPerson.frage1!)
                    foundPerson.fragen.append(foundPerson.frage2!)
                    foundPerson.fragen.append(foundPerson.frage3!)
                    foundPerson.isEntranceChecker = card.isEntranceChecker
                    foundPerson.anzahlKlopapierGekauft = card.anzahlKlopapierGekauft
                      break
                  }
              }
          }
      }
      return foundPerson
    }
    
    static func Finden(covidcode: String) -> Bool {
        
        var ref: DatabaseReference!
        var gefunden = Bool()
        
        ref = Database.database().reference()
        ref.child("User").observeSingleEvent(of: .value) { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Person(snapshot: snapshot) {
                    if card.covidcode == covidcode {
                        gefunden = true
                        break
                    }
                }
            }
        }
        return gefunden
    }
    
    
    
    
}

class Examination {
    
    var id: String?
    var result: Result
    
    init(id: String, result: Result) {
        self.id = id
        self.result = result
    }
    
    
}


enum Result {
    case positiv, negative
}


