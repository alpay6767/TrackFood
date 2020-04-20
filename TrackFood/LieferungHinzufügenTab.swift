//
//  LieferungHinzufügenTab.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 07.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import AZDialogView

class LieferungHinzufügenTab: UIViewController {
    
    
    static var currentLebensmittel: Lebensmittel?
    
    @IBOutlet weak var bild: UIImageView!
    @IBOutlet weak var bezeichnung: UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bild.image = LieferungHinzufügenTab.currentLebensmittel?.uiimage
        bezeichnung.text = LieferungHinzufügenTab.currentLebensmittel?.bezeichnung
        
    }
    
    @IBAction func erstellen(_ sender: Any) {
       saveInDatabase()
        
        //Hier eventuelle nochmal von DB Pullen
        
        self.dismiss(animated: true)
    }
    
    
    func saveInDatabase() {
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let id = ref.child("Lebensmittellieferungen").child((ViewController.currentMitarbeiter?.firmenid)!).childByAutoId().key
        ref.child("Lebensmittellieferungen").child((ViewController.currentMitarbeiter?.firmenid)!).child(id!).setValue(["Tag": getDayfromString(), "Monat": getMonthfromString(), "Jahr": getYearfromString(), "lebensmittelbarcode": LieferungHinzufügenTab.currentLebensmittel?.barcode])
    }
    
    func getPickedDateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let currentDateInString = formatter.string(from: datepicker.date)
        
        
        return currentDateInString
    }
    
    func getMonthfromString() -> Int{
        
        return Int(datepicker.date.month)!
    }
    
    func getYearfromString() -> Int{
        
        return Int(datepicker.date.year)!
    }
    
    func getDayfromString() -> Int{
        
        return Int(datepicker.date.day)!
    }
    
    
    func showDialog(worked: Bool) {
           if worked {
               let dialog = AZDialogViewController(title: "Lieferrung erstellt!", message: "Eine Lieferrung am\n" + getPickedDateAsString() + "\n wurde erstellt!")
               dialog.titleColor = .black
               dialog.messageColor = .black
               dialog.alertBackgroundColor = .white
               dialog.dismissDirection = .bottom
               dialog.dismissWithOutsideTouch = true
               dialog.showSeparator = true
               dialog.rubberEnabled = true
               dialog.blurBackground = false
               dialog.blurEffectStyle = .light
               
               dialog.imageHandler = { (imageView) in
                imageView.image = LieferungHinzufügenTab.currentLebensmittel?.uiimage
                      imageView.contentMode = .scaleAspectFill
                      return true //must return true, otherwise image won't show.
               }
               dialog.show(in: self)
               
               AppDelegate.getFilialenFromDatabase()
           } else {
               
               let dialog = AZDialogViewController(title: "Fehler", message: "Bitte fülle alle Felder aus!")
               dialog.titleColor = .black
               dialog.messageColor = .black
               dialog.alertBackgroundColor = .white
               dialog.dismissDirection = .bottom
               dialog.dismissWithOutsideTouch = true
               dialog.showSeparator = true
               dialog.rubberEnabled = true
               dialog.blurBackground = false
               dialog.blurEffectStyle = .light
               
               dialog.imageHandler = { (imageView) in
                   imageView.image = UIImage(named: "failedlogo")
                       
                      imageView.contentMode = .scaleAspectFill
                      return true //must return true, otherwise image won't show.
               }
               dialog.show(in: self)
               
               
               
           }
       }
    
}


