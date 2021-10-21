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
import FirebaseStorage

class Lebensmittel {
    
    var id: String?
    var bezeichnung: String?
    var barcode: String?
    var ablaufdatum: String?
    var image: String?
    
    var uiimage: UIImage?
    var kategorie: String?
    
    init(id: String, bezeichnung: String, barcode: String, ablaufdatum: String, image: String, kategorie: String) {
        self.id = id
        self.bezeichnung = bezeichnung
        self.barcode = barcode
        self.ablaufdatum = ablaufdatum
        self.image = image
        self.kategorie = kategorie
    }
    
    init() {
        
    }
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.id = value!["id"] as? String
        self.bezeichnung = value!["bezeichnung"] as? String
        self.barcode = value!["barcode"] as? String
        self.ablaufdatum = (value!["ablaufdatum"] as? String)!
        self.image = value!["image"] as? String
        self.kategorie = value!["kategorie"] as? String
    }
    
    
    func getUIImageFromURL(){
        let storage = Storage.storage()
        var reference: StorageReference!
        reference = storage.reference(forURL: self.image!)
        reference.downloadURL { (url, error) in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.uiimage = image!
        }
    }
    
    
}
