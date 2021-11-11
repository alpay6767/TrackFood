//
//  createFilialeTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 19.09.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class createFilialeTab: UIViewController {
    
    
    @IBOutlet weak var adresse: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    let modeldata = ModelData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        
    }
    
    func getPickedDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let currentDateInString = formatter.string(from: datePicker.date)
        
        
        return currentDateInString
    }
    
    func getMonthfromString() -> Int{
        
        return Int(datePicker.date.month)!
    }
    
    func getYearfromString() -> Int{
        
        return Int(datePicker.date.year)!
    }
    
    func getDayfromString() -> Int{
        
        return Int(datePicker.date.day)!
    }
    
    @IBAction func create(_ sender: Any) {
        
        if (name.text!.isEmpty || adresse.text!.isEmpty) {
            showBeautyfulFailedDialog(title: "Einige Infos fehlen", description: "Bitte fülle alle Felder aus!")
        } else {
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let id = ref.child("Firmen").childByAutoId().key
            let currentfirma = Filiale(id: id!, name: name.text!, address: adresse.text!, ablaufdatum: getPickedDateAsString())
            ref.child("Firmen").child(id!).setValue(["id": id, "name": currentfirma.name, "address": currentfirma.address, "ablaufdatum": currentfirma.ablaufdatum, "lizenz": currentfirma.lizenz])
            
            
        }
        
    }
     
}
