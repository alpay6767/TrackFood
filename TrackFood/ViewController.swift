//
//  ViewController.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import UIKit
import BarcodeScanner
import SwiftySound

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, BarcodeScannerCodeDelegate {

    @IBOutlet weak var menucv: UICollectionView!
    let modeldata = ModelData()
    static var currentUser: User?
    static var currentFiliale: Filiale?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menucv.delegate = self
        menucv.dataSource = self
        hideKeyboardWhenTappedAround()
        
        
    }
    
    @IBAction func logout(_ sender: Any) {
        dismiss(animated: true) {
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width/2 - 30, height: view.bounds.width/2 - 30
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeldata.main_menupoints.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentMenuPoint = modeldata.main_menupoints[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menupointcell", for: indexPath) as! MenuPointCell
            cell.bild.image = currentMenuPoint.bild
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentMenuPoint = modeldata.main_menupoints[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let newViewController: UIViewController?
        switch currentMenuPoint.name {
        case "Liste ansehen":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "listeansehentab") as! ListeAnsehenTab
            self.present(newViewController!, animated: true, completion: nil)

            break
        case "Neue Lieferung":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "neuelieferungtab") as! NeueLieferungTab
            self.present(newViewController!, animated: true, completion: nil)

            break
        case "Lebensmittel hinzufügen":
            openScanner()
            break
        case "Mein Profil":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "profiltab") as! ProfilTab
            self.present(newViewController!, animated: true, completion: nil)

            break
        case "Bald ablaufend":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "ba_nc")
            self.present(newViewController!, animated: true, completion: nil)

            break
        default:
            newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteltab") as! LebensmittelTab
            self.present(newViewController!, animated: true, completion: nil)

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
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        controller.dismiss(animated: true) {
        }
        Sound.play(file: "beep.wav")
        let fbhandler = FBHandler()
        
        
        fbhandler.checkLebensmittelBarcode(currentbarcode: code){ authentificated,foundLebensmittel  in
         guard let authentificated = authentificated else { return }
        guard let foundLebensmittel = foundLebensmittel else {return}
        
            if (authentificated) {
                LebensmittelDetailsTab.currentLebensmittel = foundLebensmittel
                print(code)
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController: UIViewController?
                newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteldetailstab") as! LebensmittelDetailsTab
                self.present(newViewController!, animated: true) {}
            } else {
                LebensmittelHinzufügenTab.barcode = code
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController: UIViewController?
                newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmittelhinzufügentab") as! LebensmittelHinzufügenTab
                self.present(newViewController!, animated: true) {}
            }
        }
    }

}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension ViewController: BarcodeScannerErrorDelegate {
     func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

extension ViewController: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}
