//
//  LebensmittelSearchTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

class LebensmittelSearchTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var lebensmittelsearchcv: UICollectionView!
    
    let modeldata = ModelData()
    static var currentList: [Lebensmittel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lebensmittelsearchcv.delegate = self
        lebensmittelsearchcv.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width, height: view.bounds.height*0.17
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LebensmittelSearchTab.currentList!.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentLebensmittel = LebensmittelSearchTab.currentList![indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lebensmittelcell", for: indexPath) as! LebensmittelCell
        cell.bild.image = currentLebensmittel.uiimage
        cell.name.text = currentLebensmittel.bezeichnung!
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        cell.bild.layer.cornerRadius = 10
        cell.bild.clipsToBounds = true
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

