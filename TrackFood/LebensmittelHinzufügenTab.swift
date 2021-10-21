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
import FirebaseStorage

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
        hideKeyboardWhenTappedAround()
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
            dismiss(animated: true) {
            }
        }
    }
    
    
    //DB Methoden:
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {

        let storageRef = Storage.storage().reference().child("Lebensmittel").child(self.currentKategoriePick!).child(LebensmittelHinzufügenTab.barcode! + ".png")
        if let uploadData = selectedImage!.jpegData(compressionQuality: 0.3) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error" + error.debugDescription)
                    completion(nil)
                } else {

                    storageRef.downloadURL(completion: { (url, error) in
                        print(url?.absoluteString)
                        completion(url?.absoluteString)
                    })

                  //  completion((metadata?.downloadURL()?.absoluteString)!))
                    // your uploaded photo url.


                }
            }
        }
    }
    
    func saveInDatabase() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        uploadMedia(){ url in
        guard let url = url else { return }
            let id = ref.child("Lebensmittel").childByAutoId().key
            let currentLebensmittel = Lebensmittel(id: id!, bezeichnung: self.bezeichnungtv.text!.description, barcode: LebensmittelHinzufügenTab.barcode!, ablaufdatum: Date().getSaveableDate(), image: url, kategorie: self.currentKategoriePick!)
            ref.child("Lebensmittel").child(id!).setValue(["id": id, "bezeichnung": currentLebensmittel.bezeichnung, "barcode": currentLebensmittel.barcode, "ablaufdatum": currentLebensmittel.ablaufdatum, "image": currentLebensmittel.image, "kategorie": currentLebensmittel.kategorie])
        }
    }
}


extension Date {
    
    func getSaveableDate() -> String {
        return day + "-" + month + "-" + year
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
