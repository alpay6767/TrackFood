//
//  FilialenDetailTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController: UIViewController?
        switch currentMenuPoint.name {
        case "Filialen":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "filialenverwaltentab") as! FilialenVerwaltenTab
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





