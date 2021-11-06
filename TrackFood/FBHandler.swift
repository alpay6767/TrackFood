//
//  FBHandler.swift
//  TheTest
//
//  Created by Alpay Kücük on 15.05.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage


class FBHandler {
    
    
    init() {
        
    }
    
    
    func getDataFromUrl(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, imageview: UIImageView) {
        print("Download Started")
        getDataFromUrl(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                imageview.image = UIImage(data: data)
            }
        }
    }
    
    func loadFirmenFromDB(completion: @escaping (_ firmenlist: [Filiale]?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Firmen").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            var newfirmenlist = [Filiale]()
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let loadedgame = Filiale(snapshot: child)
                    newfirmenlist.append(loadedgame!)
                }
                
                completion(newfirmenlist)
            }
        })
    }
    
    func loadLieferrungenFromDBForFiliale(currentfiliale: Filiale, completion: @escaping (_ firmenlist: [Lieferrung]?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Firmen").child(currentfiliale.id!).child("Lieferrungen").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            var newlieferrungenliste = [Lieferrung]()
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let loadedLieferung = Lieferrung(snapshot: child)
                    newlieferrungenliste.append(loadedLieferung!)
                }
                
                completion(newlieferrungenliste)
            }
        })
    }
    
    func loadLebensmittelFromDBWithCategoriy(currentkategorie: String, completion: @escaping (_ lebensmittelliste: [Lebensmittel]?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Lebensmittel").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            var newlebensmittelliste = [Lebensmittel]()
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let loadedLebensmittel = Lebensmittel(snapshot: child)
                    if (loadedLebensmittel?.kategorie == currentkategorie) {
                        newlebensmittelliste.append(loadedLebensmittel!)
                    }
                }
                
                completion(newlebensmittelliste)
            }
        })
    }
    
    func checkUserCredentials(username: String, password: String, completion: @escaping (_ authentificated: Bool?, _ foundUser: User?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Mitarbeiter").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                        let loadedUser = User(snapshot: child)
                    if (loadedUser?.username == username && loadedUser?.password == password) {
                            completion(true, loadedUser)
                            return
                                
                    }
                }
                completion(false, User())
            }
            else {
                completion(false, User())
            }
        })
    }
    
    func checkLebensmittelBarcode(currentbarcode: String, completion: @escaping (_ authentificated: Bool?, _ foundLebensmitttel: Lebensmittel?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Lebensmittel").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() {
                completion(false, Lebensmittel())
            }

            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let loadedlebensmittel = Lebensmittel(snapshot: child)
                    if (loadedlebensmittel?.barcode == currentbarcode) {
                            completion(true, loadedlebensmittel)
                            return
                                
                    }
                }
                completion(false, Lebensmittel())
            }
        })
    }
    
    func getFirmaMitFirmenID(currentid: String, completion: @escaping (_ authentificated: Bool?, _ foundFiliale: Filiale?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Firmen").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                        let loadedfiliale = Filiale(snapshot: child)
                    if (loadedfiliale?.id == currentid) {
                            completion(true, loadedfiliale)
                            return
                                
                    }
                }
                completion(false, Filiale())
            }
            else {
                completion(false, Filiale())
            }
        })
    }
    
    
    func checkFirmenLizenz(currentLizenz: String, completion: @escaping (_ authentificated: Bool?, _ foundFiliale: Filiale?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Firmen").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                        let loadedfiliale = Filiale(snapshot: child)
                    if (loadedfiliale?.lizenz == currentLizenz) {
                            completion(true, loadedfiliale)
                            return
                                
                    }
                }
                completion(false, Filiale())
            }
            else {
                completion(false, Filiale())
            }
        })
    }
    
    func getUsersToken(user: User, completion: @escaping (_ fertig: Bool?, _ token: String?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Mitarbeiter").child(user.id!).child("token").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            let value = snapshot.value as? [String : AnyObject]
            let tokenString = value!["token"] as? String
            completion(true, tokenString)
        })
    }
    
    func getUserByID(id: String, completion: @escaping (_ fertig: Bool?, _ foundUser: User?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Mitarbeiter").child(id).observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            let loadedUser = User(snapshot: snapshot)
            completion(true, loadedUser)
        })
    }
    
    
    func getUserByUsername(username: String, completion: @escaping (_ fertig: Bool?, _ foundUser: User?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Mitarbeiter").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let loadedUser = User(snapshot: child)
                    if (loadedUser?.username == username) {
                        completion(true, loadedUser)
                        return
                    }
                }

                completion(false, User())
            }
            else {
                completion(false, User())
            }
        })
    }
    
    /*func loadGruppenFromDB(completion: @escaping (_ gruppelist: [Gruppe]?) -> Void){

        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        ref?.child("Fortigram").child("Gruppen").observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }

            var newgruppelist = [Gruppe]()
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let loadedgame = Gruppe(snapshot: child)
                    newgruppelist.append(loadedgame!)
                }
                
                completion(newgruppelist)
            }
        })
    }
 */
    
    func uploadFotoPostForGameMedia(image: UIImage, currentlebensmittel: Lebensmittel, completion: @escaping (_ url: String?) -> Void) {

        let storageRef = Storage.storage().reference().child("Lebensmittel").child(currentlebensmittel.id!).child(currentlebensmittel.id! + ".png")
        if let uploadData = image.jpegData(compressionQuality: 0.5) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
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
    
    /*static func sendNotification(user: User, message: String) {
        
        let sender = PushSender()
        if (user.token == nil) {
            user.token = "//"
        }
        sender.sendPushNotification(to: user.token!, title: MainMenuTab.currentUser!.username!, body: message)
    }*/
        
    func saveUserToDefaults(user: User) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "LoggedIn")
        defaults.set(user.id, forKey: "id")
        defaults.set(user.username, forKey: "username")
        defaults.set(user.password, forKey: "password")
        defaults.set(user.token, forKey: "token")
        defaults.set(user.filialenid, forKey: "filialenid")

    }
    
    func saveFilialeToDefaults(filiale: Filiale) {
        let defaults = UserDefaults.standard
        defaults.set(filiale.id, forKey: "f_id")
        defaults.set(filiale.name, forKey: "name")
        defaults.set(filiale.pictureURL, forKey: "pictureURL")
        defaults.set(filiale.address, forKey: "address")
        defaults.set(filiale.city, forKey: "city")
        defaults.set(filiale.lizenz, forKey: "lizenz")
        defaults.set(filiale.zip, forKey: "zip")
        defaults.set(filiale.ablaufdatum, forKey: "ablaufdatum")

    }
    
    
    func getUserFromDefaults() -> User {
        
        let defaults = UserDefaults.standard
        let loggeduser = defaults.object(forKey: "loggeduser") as? User
        return loggeduser!
        
    }
    
    
    
}


extension UIImageView {
    func downloaded(from url: URL, mode: UIView.ContentMode) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, mode: UIView.ContentMode) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

