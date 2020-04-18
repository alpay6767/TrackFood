//
//  Berechtigungscode.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 08.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class Berechtigungscode {
    
    var id: String?
    var berechtigungscode: String?
    
    init(id: String, berechtigungscode: String) {
        self.berechtigungscode = berechtigungscode
        self.id = id
    }
    
    init() {
        
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.id = value!["id"] as? String
        self.berechtigungscode = value!["berechtigungscode"] as? String
    }
    
}
