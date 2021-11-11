//
//  AdminModeTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

class AdminModeTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    
    let modeldata = ModelData()
    
    @IBOutlet weak var adminmodecv: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        adminmodecv.delegate = self
        adminmodecv.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func logout(_ sender: Any) {
        self.dismiss(animated: true) {
        } 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width/2 - 30, height: view.bounds.width/2 - 30
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.adminmode_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.adminmode_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adminpointcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.adminmode_menupoints[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController: UIViewController?
        switch currentMenuPoint.name {
        case "Filialen":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "filialenverwalten_nc")
            break
        case "Finanzen":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "neuelieferungtab") as! NeueLieferungTab
            break
        default:
            newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteltab") as! LebensmittelTab
            break
        }
        
        self.present(newViewController!, animated: true, completion: nil)
      }


}




