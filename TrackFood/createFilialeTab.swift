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


class createFilialeTab: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var ziptxt: UITextField!
    @IBOutlet weak var adresstxt: UITextField!
    @IBOutlet weak var citypicker: UIPickerView!
    @IBOutlet weak var unternehmenpicker: UIPickerView!
    let modeldata = ModelData()
    
    var selectedCity: String?
    var selectedUnternehmen: String?
    var selectedUnternehmenObject: Unternehmen?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        citypicker.delegate = self
        unternehmenpicker.dataSource = self
        citypicker.dataSource = self
        unternehmenpicker.delegate = self
        selectedCity = modeldata.citys[0]
        selectedUnternehmen = modeldata.unternehmen[0].name
        selectedUnternehmenObject = modeldata.unternehmen[0]
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case citypicker:
            return modeldata.citys.count
        case unternehmenpicker:
            return modeldata.unternehmen.count
        default:
            printerror()
            return 0
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case citypicker:
            return modeldata.citys[row]
        case unternehmenpicker:
            return modeldata.unternehmen[row].name
        default:
            printerror()
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case citypicker:
            selectedCity = modeldata.citys[row]
        case unternehmenpicker:
            selectedUnternehmen = modeldata.unternehmen[row].name
            selectedUnternehmenObject = modeldata.unternehmen[row]
        default:
            printerror()
        }
    }
    
    
    @IBAction func create(_ sender: Any) {
        
        if (ziptxt.text!.isEmpty || adresstxt.text!.isEmpty) {
            showBeautyfulFailedDialog(title: "Einiige Infos fehlen", description: "Bitte fülle alle Felder aus!")
        } else {
            
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let id = ref.child("Firmen").childByAutoId().key
            let currentfirma = Filiale(id: id!, name: (selectedUnternehmenObject?.name)!, pictureURL: (selectedUnternehmenObject?.bildurl!)!, address: adresstxt.text!, zip: ziptxt.text!, city: selectedCity!, lizenz: generatelicenseString(), ablaufdatum: Date().getSaveableDate())
            ref.child("Firmen").child(id!).setValue(["id": id, "name": currentfirma.name, "pictureurl": currentfirma.pictureURL, "address": currentfirma.address, "zip": currentfirma.zip, "city": currentfirma.city, "ablaufdatum": currentfirma.ablaufdatum, "lizenz": currentfirma.lizenz])
            
            
        }
        
    }
    
    
    
    func generatelicenseString() -> String{
        return String((selectedUnternehmenObject?.name?.shuffled())!) + String((ziptxt.text?.shuffled())!)
    }
    
    
}


extension UIViewController {
    
    func printerror() {
        print("ERROR")
    }
    
}

extension RangeReplaceableCollection  {
    /// Returns a new collection containing this collection shuffled
    var shuffled: Self {
        var elements = self
        return elements.shuffleInPlace()
    }
    /// Shuffles this collection in place
    @discardableResult
    mutating func shuffleInPlace() -> Self  {
        indices.forEach {
            let subSequence = self[$0...$0]
            let index = indices.randomElement()!
            replaceSubrange($0...$0, with: self[index...index])
            replaceSubrange(index...index, with: subSequence)
        }
        return self
    }
    func choose(_ n: Int) -> SubSequence { return shuffled.prefix(n) }
}
