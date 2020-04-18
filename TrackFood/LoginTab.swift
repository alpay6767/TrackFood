//
//  LoginTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import UICircularProgressRing
import AZDialogView
import FirebaseDatabase

class LoginTab: UIViewController {
    
    @IBOutlet weak var progressR: UICircularProgressRing!
    @IBOutlet weak var mitarbeitercodetv: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.mitarbeitercodetv.text = defaults.string(forKey: "MyTrackFoodLoginCode")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mitarbeitercodetv.text = defaults.string(forKey: "MyTrackFoodLoginCode")
    }
    
    @IBAction func login(_ sender: Any) {
        progressR.isHidden = false
        progressR!.startProgress(to: 100, duration: 1.0) {
            if AppDelegate.schauObMitarbeiterCodeGefunden(mitarbeitercode: self.mitarbeitercodetv.text!) {
                let currentMitarbeiter = AppDelegate.searchMitarbeiter(mitarbeitercode: self.mitarbeitercodetv.text!)
        
                if currentMitarbeiter.mitarbeitercode == "s" {
                    self.openAdmin()
                } else {
                    ViewController.currentMitarbeiter = currentMitarbeiter
                    self.openHome()
                }
            }  else {
                self.showUserNotFoundDialog()
            }
            self.progressR.resetProgress()
            self.progressR.isHidden = true
        }
    }
    
    func openHome() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! ViewController
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func openAdmin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "adminmodetab") as! AdminModeTab
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    
    func showUserNotFoundDialog() {
        let dialog = AZDialogViewController(title: "Ops...", message: "Mitarbeitercode nicht gefunden!")
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
