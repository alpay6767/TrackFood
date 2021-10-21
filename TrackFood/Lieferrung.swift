//
//  Lieferrung.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 07.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Lieferrung {
    
    var date: String?
    var barcode: String?
    var lebensmittel: Lebensmittel?
    
    init(date: String, barcode: String) {
        self.date = date
        self.barcode = barcode
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject] 
        self.date = value!["date"] as? String
        self.barcode = value!["barcode"] as? String
    }
    
    
    
}
