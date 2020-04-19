//
//  LebensmittelHinzufügenTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 19.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import AZDialogView

class LebensmittelHinzufügenTab: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var selectphotobtn: UIButton!
    @IBOutlet weak var bezeichnungtv: UITextField!
    @IBOutlet weak var kategoriepicker: UIPickerView!
    
    var selectedImage: UIImage?
    
    var currentKategoriePick: String?
    static var barcode: String?
    
    var imagePicker: ImagePicker!
    let modeldata = ModelData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kategoriepicker.delegate = self
        kategoriepicker.dataSource = self
        currentKategoriePick = modeldata.kategories[0]
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

    }
    
    @IBAction func selectphoto(_ sender: Any) {
        self.imagePicker.present(from: self.view)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return modeldata.kategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return modeldata.kategories[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentKategoriePick = modeldata.kategories[row]
    }
    
    @IBAction func hinzufügen(_ sender: Any) {
        if bezeichnungtv.text!.isEmpty {
            self.showFailedDialog(message: "Bitte fülle alle Felder aus!")
        } else {
            saveInDatabase()
            AppDelegate.getLebensmittelVonDB()
            dismiss(animated: true) {
            }
        }
    }
    
    
    //DB Methoden:
    
    func saveInDatabase() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let id = ref.child("Lebensmittel").child(currentKategoriePick!).childByAutoId().key
        let currentLebensmittel = Lebensmittel(id: id!, bezeichnung: bezeichnungtv.text!.description, barcode: LebensmittelHinzufügenTab.barcode!, ablaufdatum: Date().getSaveableDate())
        ref.child("Lebensmittel").child(currentKategoriePick!).child(id!).setValue(["id": id, "bezeichnung": currentLebensmittel.bezeichnung, "barcode": currentLebensmittel.barcode, "ablaufdatum": currentLebensmittel.ablaufdatum])
    }
}


extension Date {
    
    func getSaveableDate() -> String {
        return day + " " + month + " " + year
    }
}


extension LebensmittelHinzufügenTab: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        
        if image == nil {
            
            
            
        } else {
            selectphotobtn.setImage(image, for: .normal)
            selectedImage = image
        }
    }
}
