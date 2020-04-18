//
//  registerTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 18.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import AZDialogView

class registerTab: UIViewController {
    
    @IBOutlet weak var nachname: UITextField!
    @IBOutlet weak var vorname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func registrieren(_ sender: Any) {
        if nachname.text!.isEmpty || vorname.text!.isEmpty {
            self.showFailedDialog(message: "Bitte fülle alle Felder aus!")
        } else {
            saveInDatabase()
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

        }
    }
    
    @IBAction func zurück(_ sender: Any) {
        self.dismiss(animated: true) {
        }
    }
    
    //DB Methods:
    
    func saveInDatabase() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let id = ref.child("Mitarbeiter").childByAutoId().key
        let currentNewUser = Mitarbeiter(id: id!, vorname: vorname.text!, nachname: nachname.text!, mitarbeitercode: generateMitarbeiterCode(currentid: id!))
        ref.child("Mitarbeiter").child(id!).setValue(["id": id, "mitarbeitercode": currentNewUser.mitarbeitercode, "vorname": currentNewUser.vorname, "nachname": currentNewUser.nachname])
        saveToUserDefaults(mitarbeitercode: currentNewUser.mitarbeitercode!)
    }

    func saveToUserDefaults(mitarbeitercode: String) {
        let defaults = UserDefaults.standard
        defaults.set(mitarbeitercode, forKey: "MyTrackFoodLoginCode")
        AppDelegate.getMitarbeiterFromDB()
        let loginview = presentingViewController?.presentingViewController as? LoginTab
        loginview?.mitarbeitercodetv.text = mitarbeitercode
    }
    
    func generateMitarbeiterCode(currentid: String) -> String {
        let shortenId = currentid.prefix(7)
        let mitarbeitercode = vorname.text! + shortenId
        return mitarbeitercode
    }
}
