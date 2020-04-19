//
//  ListeAnsehenTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

class ListeAnsehenTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var listeansehencv: UICollectionView!
    
    
    let modeldata = ModelData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listeansehencv.delegate = self
        listeansehencv.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width/2 - 30, height: view.bounds.width/2 - 30
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.listeansehen_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.listeansehen_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listeansehenpointcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.listeansehen_menupoints[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var newVC: UIViewController?
        
        switch currentMenuPoint.name {
        case "Backwaren":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
        break
            case "Obst":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
        break
            case "Gemüse":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
        break
            case "Fleisch & Fisch":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
        break
            case "Milchprodukte":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
        break
            case "Teigwaren":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
        break
            case "Sonstiges":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
        break
            case "Getränke":
            LebensmittelSearchTab.currentList = AppDelegate.lebensmittellist
            newVC = storyBoard.instantiateViewController(withIdentifier: "lebensmittelsearchtab") as! LebensmittelSearchTab
            break
        default:
            break
        }
        
        self.present(newVC!, animated: true, completion: nil)
      }


}


