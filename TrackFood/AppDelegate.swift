//
//  AppDelegate.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import UIKit
import Firebase
import AZDialogView
import BarcodeScanner
import FirebaseStorage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var dataSource = ModelData()
    static var filialenList = [Filiale]()
    static var lizenzcodes = [Lizenz]()
    static var mitarbeiterlist = [Mitarbeiter]()
    static var fragen = [Frage]()
    static var lebensmittellist = [Lebensmittel]()
    static var lebensmittellieferungenlist = [LebensmittelLieferung]()
    
    //Lebensmittel:
    static var backwarenlist = [Lebensmittel]()
    static var obstlist = [Lebensmittel]()
    static var gemüselist = [Lebensmittel]()
    static var fleischundfischlist = [Lebensmittel]()
    static var milchproduktlist = [Lebensmittel]()
    static var teigwarenlist = [Lebensmittel]()
    static var sonstigeslist = [Lebensmittel]()
    static var getränkelist = [Lebensmittel]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        AppDelegate.getFilialenFromDatabase()
        AppDelegate.getMitarbeiterFromDB()
        AppDelegate.getLizenzcodesFromDB()
        AppDelegate.getFragenVonDB()
        AppDelegate.pullLebensmittelFromDB()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    //DM Methoden:
    
    static func findMitarbeiterID(personId: String) -> Mitarbeiter {
           
           var counter = 0
           var gefundenePerson: Mitarbeiter?
           for currentPerson in AppDelegate.mitarbeiterlist {
               if currentPerson.id == personId {
                   gefundenePerson = AppDelegate.mitarbeiterlist[counter]
                   break
               }
               counter += 1
           }
           return gefundenePerson!
       }
       
       static func findPersonMitarbeiterCode(mitarbeitercode: String) -> Mitarbeiter {
           
           var counter = 0
           var gefundenePerson: Mitarbeiter?
           for currentPerson in AppDelegate.mitarbeiterlist {
               if currentPerson.mitarbeitercode == mitarbeitercode {
                   gefundenePerson = AppDelegate.mitarbeiterlist[counter]
                   break
               }
               counter += 1
           }
           return gefundenePerson!
       }

       
       static func getLizenzcodesFromDB() {
           
           AppDelegate.lizenzcodes.removeAll()
           var ref: DatabaseReference!
           
           ref = Database.database().reference()
           ref.child("Lizenzen").observe(.value) { snapshot in
               AppDelegate.lizenzcodes.removeAll()
               
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let card = Lizenz(snapshot: snapshot) {
                       AppDelegate.lizenzcodes.append(card)
                   }
               }
           }
       }
       
       
       static func getFragenVonDB() {
           
           AppDelegate.fragen.removeAll()
           var ref: DatabaseReference!
           
           ref = Database.database().reference()
           ref.child("Fragen").observe(.value) { snapshot in
               
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let card = Frage(snapshot: snapshot) {
                       AppDelegate.fragen.append(card)
                   }
               }
           }
           
       }
    
    static func getLebensmittelVonDB(){
        
        AppDelegate.lebensmittellist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").observe(.value) { snapshot in
            AppDelegate.lebensmittellist.removeAll()
            for child_1 in snapshot.children {
                let child_ds = child_1 as! DataSnapshot
                for child_2 in child_ds.children {
                     if let snapshot = child_2 as? DataSnapshot,
                         let card = Lebensmittel(snapshot: snapshot) {
                        card.getUIImageFromURL()
                        AppDelegate.lebensmittellist.append(card)
                     }
                }
            }
        }
        
    }
    
    static func getLebensmittellieferungenVonDB(currentFiliale: Filiale){
        
        lebensmittellist.removeAll()
        mergeAllLebensmittel()
        lebensmittellieferungenlist.removeAll()
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        ref.child("Lebensmittellieferungen").child(currentFiliale.id!).observe(.value) { snapshot in
            lebensmittellieferungenlist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = LebensmittelLieferung(snapshot: snapshot) {
                    card.lebensmittel = sucheLebensmittelFuerBarcode(barcode: card.lebensmittelbarcode!)
                    AppDelegate.lebensmittellieferungenlist.append(card)
                }
            }
        }
        
    }
    
    static func sucheLebensmittelFuerBarcode(barcode: String) -> Lebensmittel{
        for currentLebensmittel in lebensmittellist {
            if barcode == currentLebensmittel.barcode {
                return currentLebensmittel
                break
            }
        }
        return Lebensmittel()
    }
    
    //-------- LEBENSMITTEL PULLEN -----------
    
    static func mergeAllLebensmittel(){
        lebensmittellist.append(contentsOf: backwarenlist)
        lebensmittellist.append(contentsOf: obstlist)
        lebensmittellist.append(contentsOf: gemüselist)
        lebensmittellist.append(contentsOf: fleischundfischlist)
        lebensmittellist.append(contentsOf: milchproduktlist)
        lebensmittellist.append(contentsOf: teigwarenlist)
        lebensmittellist.append(contentsOf: sonstigeslist)
        lebensmittellist.append(contentsOf: getränkelist)
    }
    
    static func pullLebensmittelFromDB(){
        getBackwarenFromDB()
        getObstFromDB()
        getGemüseFromDB()
        getFleischAndFischFromDB()
        getMilchprodukteFromDB()
        getTeigwarenFromDB()
        getSonstigesFromDB()
        getGetränkeFromDB()
    }
    
    static func getBackwarenFromDB(){
        AppDelegate.backwarenlist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Backwaren").observe(.value) { snapshot in
            AppDelegate.backwarenlist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                    card.kategorie = "Backwaren"
                        card.getUIImageFromURL()
                    AppDelegate.backwarenlist.append(card)
                }
            }
        }
    }
    
    static func getObstFromDB(){
        AppDelegate.obstlist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Obst").observe(.value) { snapshot in
            AppDelegate.obstlist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                        card.kategorie = "Obst"
                        card.getUIImageFromURL()
                    AppDelegate.obstlist.append(card)
                }
            }
        }
    }
    
    static func getGemüseFromDB(){
        AppDelegate.gemüselist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Gemüse").observe(.value) { snapshot in
            AppDelegate.gemüselist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                        card.kategorie = "Gemüse"
                        card.getUIImageFromURL()
                    AppDelegate.gemüselist.append(card)
                }
            }
        }
    }
    
    static func getFleischAndFischFromDB(){
        AppDelegate.fleischundfischlist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Fleisch & Fisch").observe(.value) { snapshot in
            AppDelegate.fleischundfischlist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                        card.kategorie = "Fleisch & Fisch"
                        card.getUIImageFromURL()
                    AppDelegate.fleischundfischlist.append(card)
                }
            }
        }
    }
    
    static func getMilchprodukteFromDB(){
        AppDelegate.milchproduktlist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Milchprodukte").observe(.value) { snapshot in
            AppDelegate.milchproduktlist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                        card.kategorie = "Milchprodukte"
                        card.getUIImageFromURL()
                    AppDelegate.milchproduktlist.append(card)
                }
            }
        }
    }
    
    static func getTeigwarenFromDB(){
        AppDelegate.teigwarenlist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Teigwaren").observe(.value) { snapshot in
            AppDelegate.teigwarenlist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                        card.kategorie = "Teigwaren"
                        card.getUIImageFromURL()
                    AppDelegate.teigwarenlist.append(card)
                }
            }
        }
    }
    
    static func getSonstigesFromDB(){
        AppDelegate.sonstigeslist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Sonstiges").observe(.value) { snapshot in
            AppDelegate.sonstigeslist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                        card.kategorie = "Sonstiges"
                        card.getUIImageFromURL()
                    AppDelegate.sonstigeslist.append(card)
                }
            }
        }
    }
    
    static func getGetränkeFromDB(){
        AppDelegate.getränkelist.removeAll()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lebensmittel").child("Getränke").observe(.value) { snapshot in
            AppDelegate.getränkelist.removeAll()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let card = Lebensmittel(snapshot: snapshot) {
                        card.kategorie = "Getränke"
                        card.getUIImageFromURL()
                    AppDelegate.getränkelist.append(card)
                }
            }
        }
    }
    
    //-------- LEBENSMITTEL PULLEN END -----------
       
    static func fillwithLicenses() {
        for currentFiliale in AppDelegate.filialenList {
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let newId = ref.child("Lizenzen").childByAutoId().key
            let shortenId = currentFiliale.id!.prefix(10)
            let newlicenseCode = currentFiliale.name! + shortenId
            let newLizenz = Lizenz(id: newId!, lizenzcode: newlicenseCode, filialenid: currentFiliale.id!, ablaufdatum: "31.12.2020")
            ref.child("Lizenzen").child(newId!).setValue(["id": newLizenz.id!, "lizenzcode": newLizenz.lizenzcode!, "filialenid": newLizenz.filialenid!, "ablaufdatum": newLizenz.ablaufdatum!])
        }
    }
       
       
       static func getFilialenFromDatabase() {
           
           AppDelegate.filialenList.removeAll()
           var ref: DatabaseReference!
           
           ref = Database.database().reference()
           ref.child("Filialen").observe(.value) { snapshot in
               AppDelegate.filialenList.removeAll()
               
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let card = Filiale(snapshot: snapshot) {
                    if card.verkauftLebensmittel! {
                        AppDelegate.filialenList.append(card)
                    }
                   }
               }
           }
       }
    
    
    
       
       static func getReserviertePersonenFuerFilialen(filiale: Filiale) {
           
           filiale.reserviertePersonen.removeAll()
           var ref: DatabaseReference!
           
           ref = Database.database().reference()
           ref.child("Filialen").child(filiale.id!).child("reserviertePersonen").observe(.value) { snapshot in
               filiale.reserviertePersonen.removeAll()
               
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let card = Person(snapshot: snapshot) {
                       filiale.reserviertePersonen.append(card)
                   }
               }
           }
       }
       
       
       static func getLiefertermineFuerFiliale(filiale: Filiale) {
           
           filiale.reserviertePersonen.removeAll()
           var ref: DatabaseReference!
           
           ref = Database.database().reference()
           ref.child("Filialen").child(filiale.id!).child("Lieferrungen").observe(.value) { snapshot in
               filiale.lieferrungen.removeAll()
               
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let card = Lieferrung(snapshot: snapshot) {
                       filiale.lieferrungen.append(card)
                   }
               }
           }
       }
       
       
           
       static func getMitarbeiterFromDB() {
           
           AppDelegate.mitarbeiterlist.removeAll()
           var ref: DatabaseReference!
           
           ref = Database.database().reference()
           ref.child("Mitarbeiter").observe(.value) { snapshot in
               AppDelegate.mitarbeiterlist.removeAll()
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let card = Mitarbeiter(snapshot: snapshot) {
                       AppDelegate.mitarbeiterlist.append(card)
                   }
               }
           }
       }
       
       
       static func saveUpdatedFiliale(currentFiliale: Filiale) {
           
           var ref: DatabaseReference!
           ref = Database.database().reference()
           ref.child("Filialen").child(currentFiliale.id!).setValue(["id": currentFiliale.id!, "name": currentFiliale.name!, "pictureurl": currentFiliale.pictureURL!, "address": currentFiliale.address!, "zip": currentFiliale.zip!, "city": currentFiliale.city!, "capacity": currentFiliale.capacity!, "currentcustomers": currentFiliale.currentCustomers, "verkauftKlopapier": currentFiliale.verkauftKlopapier, "verkauftLebensmittel": currentFiliale.verkauftLebensmittel, "anzahlKlopapier": currentFiliale.anzahlKlopapier])
           //AppDelegate.getFilialenFromDatabase()
           
       }
       
       static func saveCurrentCustomer(currentFiliale: Filiale) {
           
           var ref: DatabaseReference!
           ref = Database.database().reference()
           ref.child("Filialen").child(currentFiliale.id!).child("currentcustomers").setValue( currentFiliale.currentCustomers)
           
       }
       
       
       
       
       
       static func deleteReservation(currentFiliale: Filiale, currentPerson: Person) {
           
           var ref: DatabaseReference!
           ref = Database.database().reference()
           ref.child("Filialen").child(currentFiliale.id!).child("reserviertePersonen").child(currentPerson.id!).removeValue()
           
       }
       
       
       static func saveAnzahlKlopapier(currentFiliale: Filiale) {
           
           var ref: DatabaseReference!
           ref = Database.database().reference()
           ref.child("Filialen").child(currentFiliale.id!).child("anzahlKlopapier").setValue( currentFiliale.anzahlKlopapier)
           
       }
       
       
       static func deleteAllReservations(currentFiliale: Filiale) {
           
           saveUpdatedFiliale(currentFiliale: currentFiliale)
           
       }
       
       static func deleteAllReservationsOfAllFilialen() {
           for currentFiliale in filialenList {
               AppDelegate.deleteAllReservations(currentFiliale: currentFiliale)
           }
       }
       
       
       static func searchLizenzcode(lizenzcode: String) -> Lizenz {
            for currentCode in lizenzcodes {
                if currentCode.lizenzcode == lizenzcode {
                    return currentCode
                }
            }
            return Lizenz()
        }
       
       
       static func searchMitarbeiter(mitarbeitercode: String) -> Mitarbeiter {
           for currentMitarbeiter in mitarbeiterlist {
               if currentMitarbeiter.mitarbeitercode == mitarbeitercode {
                   return currentMitarbeiter
               }
           }
           return Mitarbeiter()
       }
    
    
    static func schauObLebensmittelGefunden(barcode: String) -> Bool {
        for currentLebensmittel in lebensmittellist {
            if currentLebensmittel.barcode == barcode {
                return true
            }
         }
        return false
    }
    
    static func sucheLebensmittelInListe(barcode: String) -> Lebensmittel {
        for currentLebensmittel in lebensmittellist {
            if currentLebensmittel.barcode == barcode {
                return currentLebensmittel
            }
         }
        return Lebensmittel()
    }
       
       static func schauObMitarbeiterCodeGefunden(mitarbeitercode: String) -> Bool {
           for currentUser in mitarbeiterlist {
            if currentUser.mitarbeitercode == mitarbeitercode {
                   return true
               }
           }
           return false
       }
       
       static func schauObLizenzCodeGefunden(lizenzcode: String) -> Bool {
           for currentCode in lizenzcodes {
               if currentCode.lizenzcode == lizenzcode {
                   return true
               }
           }
           return false
       }
    
    static func schauObProduktBereitsVorhanden(lizenzcode: String) -> Bool {
        for currentLebensmittel in lizenzcodes {
            if currentLebensmittel.lizenzcode == lizenzcode {
                return true
            }
        }
        return false
    }
    
    
    static func mergeLizenzWithFilialen() {
        for currentFiliale in AppDelegate.filialenList {
            for currentLizenz in AppDelegate.lizenzcodes {
                if currentLizenz.filialenid == currentFiliale.id {
                    currentFiliale.lizenz = currentLizenz
                    break
                }
            }
        }
    }
    
    
    static func findFilialeWithFilialenID(filialenid: String) -> Filiale {
        
        var counter = 0
        var gefundeneFiliale: Filiale?
        for currentFiliale in AppDelegate.filialenList {
            if currentFiliale.id == filialenid {
                gefundeneFiliale = AppDelegate.filialenList[counter]
                break
            }
            counter += 1
        }
        return gefundeneFiliale!
    }


}



extension UIViewController {
    
    func showFailedDialog(message: String) {
            
            let dialog = AZDialogViewController(title: "Fehler", message: message)
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
    
    func showSuccessDialog(message: String) {
            
            let dialog = AZDialogViewController(title: "OK", message: message)
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
                imageView.image = UIImage(named: "erfolglogo")
                    
                   imageView.contentMode = .scaleAspectFill
                   return true //must return true, otherwise image won't show.
            }
            dialog.show(in: self)
            
    }
    
    /*func showAskDialog(buttontext: String, message: String) {
        let dialog = AZDialogViewController(title: "Bist du sicher?", message: message)
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
            imageView.image = UIImage(named: "asklogo")
                
               imageView.contentMode = .scaleAspectFill
               return true //must return true, otherwise image won't show.
        }
        
        dialog.addAction(AZDialogAction(title: buttontext) { (dialog) -> (Void) in
            
            dialog.dismiss()
        })
        dialog.show(in: self)
    }
 */
    
}


extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: self)
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
}


extension ViewController: BarcodeScannerCodeDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    print(code)
    controller.reset()
  }
}
