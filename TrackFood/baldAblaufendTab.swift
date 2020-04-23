//
//  baldAblaufendTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class baldAblaufendTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var baldablaufendlieferungencv: UICollectionView!
    
    
    let modeldata = ModelData()
    static var currentList: [Lebensmittel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baldablaufendlieferungencv.delegate = self
        baldablaufendlieferungencv.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width, height: view.bounds.height*0.15
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppDelegate.lebensmittellieferungenlist.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentLebensmittelLieferung = AppDelegate.lebensmittellieferungenlist[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lebensmittellieferrungencell", for: indexPath) as! LebensmittelLieferungCell
        cell.bild.image = currentLebensmittelLieferung.lebensmittel!.uiimage
        cell.name.text = currentLebensmittelLieferung.lebensmittel!.bezeichnung!
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        cell.bild.layer.cornerRadius = 10
        cell.bild.clipsToBounds = true
        cell.verfallsdatum.text = (currentLebensmittelLieferung.tag?.description)! + "." +  (currentLebensmittelLieferung.monat?.description)! + "." +  (currentLebensmittelLieferung.jahr?.description)!
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentLebensmittelLieferung = AppDelegate.lebensmittellieferungenlist[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        LebensmittelDetailsTab.currentLebensmittel = currentLebensmittelLieferung.lebensmittel
        let newViewController: UIViewController?
            newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteldetailstab") as! LebensmittelDetailsTab
            present(newViewController!, animated: true) {
        }
    }
    
    
}

