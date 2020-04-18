//
//  Lizenz.swift
//  TrackFood
//
//  Created by Alpay Kücük on 18.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Lizenz {
    
    var id: String?
    var lizenzcode: String?
    var filialenid: String?
    var ablaufdatum: String?
    
    init(id: String, lizenzcode: String, filialenid: String, ablaufdatum: String) {
        self.id = id
        self.lizenzcode = lizenzcode
        self.filialenid = filialenid
        self.ablaufdatum = ablaufdatum
    }
    
    init() {
        
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.id = value!["id"] as? String
        self.lizenzcode = value!["lizenzcode"] as? String
        self.filialenid = value!["filialenid"] as? String
        self.ablaufdatum = value!["ablaufdatum"] as? String
    }

}
