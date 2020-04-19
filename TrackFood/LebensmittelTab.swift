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
            openScanner()
            break
        default:
            break
        }
      }

    func openScanner() {
        let viewController = BarcodeScannerViewController()
        viewController.headerViewController.titleLabel.text = "Barcode scannen"
        viewController.messageViewController.textLabel.text = "Platziere den Barcode vor die Kamera um es einzuscannen. Die Suche startet automatisch!"
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        viewController.isOneTimeSearch = true

        present(viewController, animated: true, completion: nil)
    }

}

extension LebensmittelTab: BarcodeScannerErrorDelegate {
     func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

extension LebensmittelTab: BarcodeScannerCodeDelegate {
   func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    controller.dismiss(animated: true) {
    }
    
    if AppDelegate.schauObLebensmittelGefunden(barcode: code) {
        print("Code gefunden: " + (AppDelegate.sucheLebensmittelInListe(barcode: code)).bezeichnung!)
    } else {
    
        LebensmittelHinzufügenTab.barcode = code
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController: UIViewController?
        newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmittelhinzufügentab") as! LebensmittelHinzufügenTab
        present(newViewController!, animated: true) {}
    }
    
}
}

extension LebensmittelTab: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
