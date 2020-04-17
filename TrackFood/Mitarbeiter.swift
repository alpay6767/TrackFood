//
//  Mitarbeiter.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

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
    
}
