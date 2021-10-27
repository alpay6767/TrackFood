//
//  LebensmittelTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import BarcodeScanner
import SwiftySound

class LebensmittelTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var lebensmittelcv: UICollectionView!
    
    let modeldata = ModelData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lebensmittelcv.delegate = self
        lebensmittelcv.dataSource = self
        hideKeyboardWhenTappedAround()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width/2 - 30, height: view.bounds.width/2 - 30
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.lebensmittel_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.lebensmittel_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lebensmittelpointcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.lebensmittel_menupoints[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController: UIViewController?
        switch currentMenuPoint.name {
        case "Liste ansehen":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "listeansehentab") as! ListeAnsehenTab
            present(newViewController!, animated: true) {
            }
            break
        case "Neue Lieferung":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "neuelieferungtab") as! NeueLieferungTab
            present(newViewController!, animated: true) {
            }
            break
        case "Lebensmittel hinzufügen":
            break
        default:
            break
        }
      }


}


