//
//  NeueLieferungTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import BarcodeScanner
import SwiftySound


class NeueLieferungTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    @IBOutlet weak var neuelieferungcv: UICollectionView!
    
    let modeldata = ModelData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        neuelieferungcv.delegate = self
        neuelieferungcv.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width/2 - 30, height: view.bounds.width/2 - 30
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.neueLieferung_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.neueLieferung_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "neuelieferungpointcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.neueLieferung_menupoints[indexPath.item]
        
        switch currentMenuPoint.name {
        case "Scannen":
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

extension NeueLieferungTab: BarcodeScannerErrorDelegate {
     func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

extension NeueLieferungTab: BarcodeScannerCodeDelegate {
   func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    controller.dismiss(animated: true) {
    }
    
    Sound.play(file: "beep.wav")
    let fbhandler = FBHandler()
    
    
    fbhandler.checkLebensmittelBarcode(currentbarcode: code){ authentificated,foundLebensmittel  in
     guard let authentificated = authentificated else { return }
    guard let foundLebensmittel = foundLebensmittel else {return}
    
        if (authentificated) {
            LieferungHinzufügenTab.currentLebensmittel = foundLebensmittel
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController: UIViewController?
            newViewController = storyBoard.instantiateViewController(withIdentifier: "addlieferrung_nc")
            self.present(newViewController!, animated: true) {}
        } else {
            LebensmittelHinzufügenTab.barcode = code
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController: UIViewController?
            newViewController = storyBoard.instantiateViewController(withIdentifier: "produkthinzufuegen_nc")
            self.present(newViewController!, animated: true) {}
        }
    }
}
}

extension NeueLieferungTab: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}




