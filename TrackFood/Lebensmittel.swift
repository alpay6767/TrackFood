//
//  Lebensmittel.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Lebensmittel {
    
    var id: String?
    var bezeichnung: String?
    var barcode: String?
    var ablaufdatum: String?
    
    init(id: String, bezeichnung: String, barcode: String, ablaufdatum: String) {
        self.id = id
        self.bezeichnung = bezeichnung
        self.barcode = barcode
        self.ablaufdatum = ablaufdatum
    }
    
    init() {
        
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.id = value!["id"] as? String
        self.bezeichnung = value!["bezeichnung"] as? String
        self.barcode = value!["barcode"] as? String
        self.ablaufdatum = (value!["ablaufdatum"] as? String)!
    }
}
