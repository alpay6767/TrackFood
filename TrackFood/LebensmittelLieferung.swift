//
//  LebensmittelLieferung.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 07.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class LebensmittelLieferung {
    
    var date: Date?
    var tag: Int?
    var monat: Int?
    var jahr: Int?
    var lebensmittelbarcode: String?
    var lebensmittel: Lebensmittel?
    
    init(date: Date) {
        self.date = date
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.tag = value!["Tag"] as? Int
        self.monat = value!["Monat"] as? Int
        self.jahr = value!["Jahr"] as? Int
        self.lebensmittelbarcode = value!["lebensmittelbarcode"] as? String
    }
    
    
    func getStringMonth() -> String {
        
        switch monat {
        case 1:
            return "JAN"
        case 2:
            return "FEB"
        case 3:
            return "MAR"
        case 4:
            return "APR"
        case 5:
            return "MAI"
        case 6:
            return "JUN"
        case 7:
            return "JUL"
        case 8:
            return "AUG"
        case 9:
            return "SEP"
        case 10 :
            return "OKT"
        case 11:
            return "NOV"
        case 12:
            return "DEC"
        default:
            return "NULL"
        }
        
        
    }
    
    
}

