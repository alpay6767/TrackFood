//
//  ProfilTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import AZDialogView

class ProfilTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let modeldata = ModelData()
    @IBOutlet weak var profiletabcv: UICollectionView!
    
    @IBOutlet weak var nametv: UILabel!
    @IBOutlet weak var mitarbeitertv: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profiletabcv.delegate = self
        profiletabcv.dataSource = self
        hideKeyboardWhenTappedAround()
        
        nametv.text = (ViewController.currentMitarbeiter?.vorname)! + " " +  (ViewController.currentMitarbeiter?.nachname)!
        mitarbeitertv.text = (ViewController.currentMitarbeiter?.mitarbeitercode)!
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width/2 - 30, height: view.bounds.width/2 - 30
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.profile_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.profile_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.profile_menupoints[indexPath.item]
        
        switch currentMenuPoint.name {
        case "Profil löschen":
            askDeleteProfile()
            break
        default:
            print("Default")
            break
        }
        
      }
    
    func profillöschen() {
        let ref = Database.database().reference()
        ref.child("Mitarbeiter").child((ViewController.currentMitarbeiter?.id)!).removeValue()
    }
    
    func askDeleteProfile() {
        let dialog = AZDialogViewController(title: "Bist du sicher?", message: "Willst du den deinen Account wirklich löschen?")
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
        
        dialog.addAction(AZDialogAction(title: "Löschen") { (dialog) -> (Void) in
            self.profillöschen()
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
            AppDelegate.getMitarbeiterFromDB()
            dialog.dismiss()
        })
        dialog.show(in: self)
    }


}






