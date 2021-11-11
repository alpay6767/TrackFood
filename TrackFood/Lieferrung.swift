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
import SwiftDate

class Lieferrung {
    
    var id: String?
    var date: String?
    var barcode: String?
    var lebensmittel: Lebensmittel?
    var dateFormtatted: Date?
    
    init(id: String, date: String, barcode: String) {
        self.date = date
        self.barcode = barcode
        self.id = id
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"// yyyy-MM-dd"
        self.dateFormtatted = dateFormatter.date(from: self.date!)
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject] 
        self.date = value!["date"] as? String
        self.barcode = value!["barcode"] as? String
        self.id = value!["id"] as? String
        
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"// yyyy-MM-dd"
        self.dateFormtatted = dateFormatter.date(from: self.date!)
    }
    
    func getColorForLieferung() -> UIColor {
        let dateFormatted = date!.toDate("dd-MM-yyyy")
        if (dateFormatted?.compare(.isNextWeek))! || (dateFormatted?.compare(.isThisWeek))! {
            return Constants.DATECOLOR_SOON
        }
        if (dateFormatted?.compare(.isThisMonth))! {
            return Constants.DATECOLOR_MIDDLE
        }
        if (dateFormatted?.compare(.isThisYear))! {
            return Constants.DATECOLOR_FAR
        }
        return Constants.DATECOLOR_DEFAULT
    }
    
    
}
