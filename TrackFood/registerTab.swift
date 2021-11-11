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
    
    static var currentFiliale: Filiale?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func registrieren(_ sender: Any) {
        if nachname.text!.isEmpty || vorname.text!.isEmpty {
            self.showFailedDialog(message: "Bitte fülle alle Felder aus!")
        } else {
            saveInDatabase()
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)

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
        let currentnewuser = User(id: id!, username: vorname.text!, password: nachname.text!, token: "", firmenid: (registerTab.currentFiliale?.id)!)
        ref.child("Mitarbeiter").child(id!).setValue(["id": id, "username": currentnewuser.username, "password": currentnewuser.password, "token": currentnewuser.token, "firmenid": currentnewuser.firmenid])
    }

}
