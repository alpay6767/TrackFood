//
//  PasswordAendernTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 10.11.21.
//  Copyright © 2021 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import BLTNBoard

class PasswordAendernTab: UIViewController {
    
    @IBOutlet weak var altesPassword: UITextField!
    @IBOutlet weak var neuesPassword1: UITextField!
    @IBOutlet weak var ändernBtn: UIButton!
    @IBOutlet weak var neuesPassword2: UITextField!
    
    var bulletinManager : BLTNItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Password ändern"
    }
    
    @IBAction func ändern(_ sender: Any) {
        if (altesPassword.text! != ViewController.currentUser?.password) || (neuesPassword1.text! != neuesPassword2.text!) {
            let page = BLTNPageItem(title: "Passwörter stimmen nicht überein!")
            page.image = #imageLiteral(resourceName: "guy2")
            
            page.descriptionText = "kontrollier nochmal ob alle Angaben richtig sind"
            page.actionButtonTitle = "Ok"
            page.actionHandler = { (item: BLTNActionItem) in
                self.vibratePhone()
                item.manager?.dismissBulletin(animated: true)
            }
            let rootItem: BLTNItem = page
            self.bulletinManager = BLTNItemManager(rootItem: rootItem)
            self.bulletinManager!.showBulletin(above: self)
        } else {
            ViewController.currentUser?.updatePassword(password: neuesPassword1.text!)
            let page = BLTNPageItem(title: "Passwörter erfolgreich geändert!")
            page.image = #imageLiteral(resourceName: "people")
            
            page.descriptionText = "Dein Password wurde geändert"
            page.actionButtonTitle = "Ok"
            page.actionHandler = { (item: BLTNActionItem) in
                self.vibratePhone()
                item.manager?.dismissBulletin(animated: true)
            }
            let rootItem: BLTNItem = page
            self.bulletinManager = BLTNItemManager(rootItem: rootItem)
            self.bulletinManager!.showBulletin(above: self)
        }
        
    }
}
