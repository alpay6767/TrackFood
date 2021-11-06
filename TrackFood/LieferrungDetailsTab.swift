//
//  LieferrungDetailsTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import AZDialogView
import Kingfisher

class LieferrungDetailsTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    static var currentLieferrung: Lieferrung?
    
    @IBOutlet weak var lebensmitteldetailscv: UICollectionView!
    let modeldata = ModelData()
    
    @IBOutlet weak var ablaufdatum: UILabel!
    @IBOutlet weak var ablaufdatum_layout: UIView!
    @IBOutlet weak var bild: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lebensmitteldetailscv.delegate = self
        lebensmitteldetailscv.dataSource = self
        hideKeyboardWhenTappedAround()
        
        let url = URL(string: (LieferrungDetailsTab.currentLieferrung?.lebensmittel?.image)!)
        bild.kf.setImage(with: url)
        bild.layer.cornerRadius = bild.bounds.width/2
        bild.clipsToBounds = true
        name.text = LieferrungDetailsTab.currentLieferrung?.lebensmittel?.bezeichnung
        
        ablaufdatum.text = LieferrungDetailsTab.currentLieferrung?.date
        ablaufdatum_layout.backgroundColor = LieferrungDetailsTab.currentLieferrung?.getColorForLieferung()
        ablaufdatum_layout.layer.cornerRadius = 10
        ablaufdatum_layout.clipsToBounds = true
        
        self.navigationItem.title = LebensmittelDetailsTab.currentLebensmittel?.bezeichnung
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.bounds.width/2 - 70, height: view.bounds.width/2 - 70
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.lebensmitteldetails_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.lebensmitteldetails_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lebensmitteldetailspointcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.lebensmitteldetails_menupoints[indexPath.item]
        switch currentMenuPoint.name {
        case "Löschen":
            askDeleteLebensmittel()
            break
        default:
            break
        }
      }
    
    
    func LebensmittelLöschen() {
        let ref = Database.database().reference()
        ref.child("Lebensmittel").child((LebensmittelDetailsTab.currentLebensmittel!.kategorie)!).child((LebensmittelDetailsTab.currentLebensmittel?.id)!).removeValue()
        
        let storageRef = Storage.storage().reference().child("Lebensmittel").child((LebensmittelDetailsTab.currentLebensmittel?.kategorie)!).child((LebensmittelDetailsTab.currentLebensmittel?.barcode)! + ".png")
        storageRef.delete { error in
            if let error = error {
                print(error)
            } else {
                // File deleted successfully
            }
        }
    }
    
    func askDeleteLebensmittel() {
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
            self.LebensmittelLöschen()
            self.presentedViewController?.dismiss(animated: true, completion: {
                
            })
            dialog.dismiss()
        })
        dialog.show(in: self)
    }



}





