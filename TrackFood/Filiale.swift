//
//  Filiale.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 21.03.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import SwiftDate


class Filiale {
    
    var id: String?
    var name: String?
    var address: String?
    var lizenz: String?
    var ablaufdatum: String?
    
    
    init(id: String, name: String, address: String, ablaufdatum: String) {
        self.id = id
        self.name = name
        self.address = address
        self.lizenz = randomString(length: 8)
        self.ablaufdatum = ablaufdatum
    }
    
    init(id: String, name: String, address: String, lizenz: String, ablaufdatum: String) {
        self.id = id
        self.name = name
        self.address = address
        self.lizenz = lizenz
        self.ablaufdatum = ablaufdatum
    }
    
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.name = value!["name"] as? String
        self.id = value!["id"] as? String
        self.address = value!["address"] as? String
        self.ablaufdatum = value!["ablaufdatum"] as? String
        self.lizenz = value!["lizenz"] as? String
    }
    
    init() {
        
    }
    
    func renewLicensForAYear() {
        var currentlicense = self.ablaufdatum?.toDate("dd-MM-yyyy")
        currentlicense = currentlicense! + 1.years
        self.ablaufdatum = currentlicense?.toString(DateToStringStyles.custom("dd-MM-yyyy"))
        let ref = Database.database().reference()
        ref.child("Firmen").child((self.id)!).child("ablaufdatum").setValue(self.ablaufdatum)        
    }
    
    func renewLicensForAMonth() {
        var currentlicense = self.ablaufdatum?.toDate("dd-MM-yyyy")
        currentlicense = currentlicense! + 1.months
        self.ablaufdatum = currentlicense?.toString(DateToStringStyles.custom("dd-MM-yyyy"))
        let ref = Database.database().reference()
        ref.child("Firmen").child((self.id)!).child("ablaufdatum").setValue(self.ablaufdatum)
    }
    
    func renewLicenseKey() {
        let newkey = randomString(length: 8)
        self.lizenz = newkey
        let ref = Database.database().reference()
        ref.child("Firmen").child((self.id)!).child("lizenz").setValue(self.lizenz)
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
}
