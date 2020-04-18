//
//  AppDelegate.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var dataSource = ModelData()
    static var filialenList = [Filiale]()
    static var lizenzcodes = [Lizenz]()
    static var mitarbeiterlist = [Mitarbeiter]()
    static var fragen = [Frage]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        AppDelegate.getFilialenFromDatabase()
        AppDelegate.getMitarbeiterFromDB()
        AppDelegate.getLizenzcodesFromDB()
        AppDelegate.getFragenVonDB()
        mergeLizenzWithFilialen()
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
       
       
       
       
       static func getFilialenFromDatabase() {
           
           AppDelegate.filialenList.removeAll()
           var ref: DatabaseReference!
           
           ref = Database.database().reference()
           ref.child("Filialen").observe(.value) { snapshot in
               AppDelegate.filialenList.removeAll()
               
               for child in snapshot.children {
                   if let snapshot = child as? DataSnapshot,
                       let card = Filiale(snapshot: snapshot) {
                       AppDelegate.filialenList.append(card)
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
    
    
    func mergeLizenzWithFilialen() {
        for currentFiliale in AppDelegate.filialenList {
            for currentLizenz in AppDelegate.lizenzcodes {
                if currentLizenz.filialenid == currentFiliale.id {
                    currentFiliale.lizenz = currentLizenz
                    break
                }
            }
        }
    }


}

