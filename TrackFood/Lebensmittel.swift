//
//  Lebensmittel.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

class Lebensmittel {
    
    var id: String?
    var bezeichnung: String?
    var barcode: String?
    var ablaufdatum: String?
    
    init(id: String, bezeichnung: String, barcode: String, ablaufdatum: String) {
        self.id = id
    }
    
}
