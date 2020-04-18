//
//  FilialenDetailTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import AZDialogView

class FilialenDetailTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    static var currentFiliale: Filiale?
    let modeldata = ModelData()
    
    @IBOutlet weak var anschrift: UILabel!
    @IBOutlet weak var bild: UIImageView!
    @IBOutlet weak var filialendetailcv: UICollectionView!
    @IBOutlet weak var lizenzcode: UILabel!
    @IBOutlet weak var ablaufdatum: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filialendetailcv.delegate = self
        filialendetailcv.dataSource = self
        hideKeyboardWhenTappedAround()
        bild.downloaded(from: (FilialenDetailTab.currentFiliale?.pictureURL)!)
        anschrift.text = (FilialenDetailTab.currentFiliale?.name)! + " " + (FilialenDetailTab.currentFiliale?.address)! + " " + (FilialenDetailTab.currentFiliale?.city)!
        lizenzcode.text = FilialenDetailTab.currentFiliale?.lizenz?.lizenzcode
        ablaufdatum.text = FilialenDetailTab.currentFiliale?.lizenz?.ablaufdatum
        
        
        listenToLizenzcode()
        listenToAblaufDatum()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width/2 - 30, height: view.bounds.width/2 - 30
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.filialendetails_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.filialendetails_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filialedetailcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.filialendetails_menupoints[indexPath.item]
        
        switch currentMenuPoint.name {
        case "Lizenzerneuern":
            askAblaufdatumErneuern()
            break
        case "Codeerneuern":
            askLizenzCodeErneuern()
            break
        default:
            print("Default")
            break
        }
        
      }
    
    
    
    
    func lizenzErneuern() {
        FilialenDetailTab.currentFiliale?.lizenz?.updateLizenze()
    }

    
    func codeErneuern() {
        
    }
    
    //DB Methoden:
    func listenToAblaufDatum() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lizenzen").child((FilialenDetailTab.currentFiliale?.lizenz!.id)!).child("ablaufdatum").observe(.value) { snapshot in
            FilialenDetailTab.currentFiliale?.lizenz?.updateAblaufDatum(snapshot: snapshot)
            self.ablaufdatum.text = FilialenDetailTab.currentFiliale?.lizenz?.ablaufdatum
        }
    }
    
    func listenToLizenzcode() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Lizenzen").child((FilialenDetailTab.currentFiliale?.lizenz!.id)!).child("lizenzcode").observe(.value) { snapshot in
            FilialenDetailTab.currentFiliale?.lizenz?.updateLizenzcode(snapshot: snapshot)
            self.lizenzcode.text = FilialenDetailTab.currentFiliale?.lizenz?.lizenzcode
        }
    }
    
    func askLizenzCodeErneuern() {
        let dialog = AZDialogViewController(title: "Bist du sicher?", message: "Willst du den Lizenzcode wirklich erneuern?")
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
        
        dialog.addAction(AZDialogAction(title: "Erneuern") { (dialog) -> (Void) in
            self.codeErneuern()
            dialog.dismiss()
        })
        dialog.show(in: self)
    }
    
    func askAblaufdatumErneuern() {
        let dialog = AZDialogViewController(title: "Bist du sicher?", message: "Willst du das Ablaufdatum wirklich erneuern?")
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
        
        dialog.addAction(AZDialogAction(title: "Erneuern") { (dialog) -> (Void) in
            self.lizenzErneuern()
            dialog.dismiss()
        })
        dialog.show(in: self)
    }

}





