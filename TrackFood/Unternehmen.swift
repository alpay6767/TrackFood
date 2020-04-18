//
//  Unternehmen.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 23.03.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

class Unternehmen {
    
    var name: String?
    var bildurl: String?
    var verkauftKlopapier: Bool?
    var verkauftLebensmittel: Bool?
    
    
    init(name: String, bildurl: String, verkauftKlopapier: Bool, verkauftLebensmittel: Bool) {
        self.name = name
        self.bildurl = bildurl
        self.verkauftKlopapier = verkauftKlopapier
        self.verkauftLebensmittel = verkauftLebensmittel
    }
    
    
    
}
