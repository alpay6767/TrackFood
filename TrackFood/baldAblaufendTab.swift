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
import Kingfisher
import SwiftDate

class baldAblaufendTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var baldablaufendlieferungencv: UICollectionView!
    
    
    let modeldata = ModelData()
    var lieferrungenListe = [Lieferrung]()
    let fbhandler = FBHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baldablaufendlieferungencv.delegate = self
        baldablaufendlieferungencv.dataSource = self
        hideKeyboardWhenTappedAround()
        loadLieferrungen()
    }
    
    
    func loadLieferrungen() {
        
        fbhandler.loadLieferrungenFromDBForFiliale(currentfiliale: ViewController.currentFiliale!) { [self] lieferrungenliste in
             guard let lieferrungenliste = lieferrungenliste else { return }
                
            self.lieferrungenListe = lieferrungenliste
            matchLebensmittel(currentlieferrungen: self.lieferrungenListe)
            
            
        }
        
    }
    
    func matchLebensmittel(currentlieferrungen: [Lieferrung]) {
        for currentlie in currentlieferrungen
        {
            fbhandler.checkLebensmittelBarcode(currentbarcode: currentlie.barcode!) { [self] gefunden, gefundenesItem in
                guard let gefunden = gefunden else { return }
                guard let gefundenesItem = gefundenesItem else { return }
                
                if (gefunden) {
                    currentlie.lebensmittel = gefundenesItem
                    sortArray()
                    self.baldablaufendlieferungencv.reloadData()
                }
                
            }
        }
        
        
    }
    
    
    func sortArray() {

        
        //let ready = DateInRegion.sortedByOldest(list: getDateInRegions())
        
        self.lieferrungenListe = self.lieferrungenListe.sorted(by: { $0.dateFormtatted!.compare($1.dateFormtatted!) == .orderedAscending })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width, height: 80
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (lieferrungenListe.count)
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentLebensmittelLieferung = lieferrungenListe[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lebensmittellieferrungencell", for: indexPath) as! LebensmittelLieferungCell
        let url = URL(string: (currentLebensmittelLieferung.lebensmittel?.image)!)
        cell.bild.kf.setImage(with: url!)
        cell.name.text = currentLebensmittelLieferung.lebensmittel!.bezeichnung!
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        cell.bild.layer.cornerRadius = 5
        cell.bild.clipsToBounds = true
        cell.verfallsdatum.text = currentLebensmittelLieferung.date!
        cell.date_view.backgroundColor = currentLebensmittelLieferung.getColorForLieferung()
        cell.date_view.layer.cornerRadius = 10
        cell.date_view.clipsToBounds = true
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentLebensmittelLieferung = lieferrungenListe[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        LieferrungDetailsTab.currentLieferrung = currentLebensmittelLieferung
        let newViewController: UIViewController?
            newViewController = storyBoard.instantiateViewController(withIdentifier: "lieferrungdetailstab") as! LieferrungDetailsTab
        self.navigationController?.pushViewController(newViewController!, animated: true)
    }
    
    
}

