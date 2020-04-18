//
//  Frage.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 09.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Frage {
    
    var frage: String?
    
    init(frage: String) {
        self.frage = frage
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.frage = value!["frage"] as? String
    }
}
