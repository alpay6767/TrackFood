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
    static var lebensmittellist = [Lebensmittel]()

    
    //Lebensmittel:
    static var backwarenlist = [Lebensmittel]()
    static var obstlist = [Lebensmittel]()
    static var gemüselist = [Lebensmittel]()
    static var fleischundfischlist = [Lebensmittel]()
    static var milchproduktlist = [Lebensmittel]()
    static var teigwarenlist = [Lebensmittel]()
    static var sonstigeslist = [Lebensmittel]()
    static var getränkelist = [Lebensmittel]()
    
    
    static var counter = 1
    let fbhandler = FBHandler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

        let defaults = UserDefaults.standard
        let loggedin = defaults.bool(forKey: "LoggedIn")
        let eula = defaults.bool(forKey: "eula")
        if loggedin == nil {
            defaults.set(false, forKey: "LoggedIn")
        }
        if eula == nil {
            defaults.set(false, forKey: "eula")
        }
        
        //IQKeyboardManager.shared.enable = true //pods importieren!
        
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
    
    static func getUserFromDefaults() -> User {
        
        let defaults = UserDefaults.standard
        let id = defaults.string(forKey: "id")
        let username = defaults.string(forKey: "username")
        let password = defaults.string(forKey: "password")
        let token = defaults.string(forKey: "token")
        let firmenid = defaults.string(forKey: "firmenid")
        let foundUser = User(id: id!, username: username!, password: password!, token: token!, firmenid: firmenid!)
        return foundUser
        
    }
    
    static func getFilialeFromDefaults() -> Filiale {
        
        let defaults = UserDefaults.standard
        let id = defaults.string(forKey: "f_id")
        let name = defaults.string(forKey: "name")
        let address = defaults.string(forKey: "address")
        let lizenz = defaults.string(forKey: "lizenz")
        let ablaufdatum = defaults.string(forKey: "ablaufdatum")
        let currentfiliale = Filiale(id: id!, name: name!, address: address!, lizenz: lizenz!, ablaufdatum: ablaufdatum!)
        return currentfiliale
        
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

