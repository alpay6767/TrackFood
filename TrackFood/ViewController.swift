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
import FirebaseDatabase
import BLTNBoard

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, BarcodeScannerCodeDelegate {

    @IBOutlet weak var menucv: UICollectionView!
    let modeldata = ModelData()
    static var currentUser: User?
    static var currentFiliale: Filiale?
    var bulletinManager: BLTNItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menucv.delegate = self
        menucv.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func logout(_ sender: Any) {
        let bulletinItem = createBulletinBoardItemForLogout(title: "Willst du dich wirklich ausloggen?", description: "Du musst dich dann wieder anmelden!", actionButtonText: "Ausloggen", alternativeButtonText: "abbrechen", image: #imageLiteral(resourceName: "people"))
        self.bulletinManager = BLTNItemManager(rootItem: bulletinItem)
        
        self.bulletinManager!.showBulletin(above: self)
    }
    
    func createBulletinBoardItemForLogout(title: String, description: String, actionButtonText: String, alternativeButtonText: String, image: UIImage) -> BLTNItem {
        let page = BLTNPageItem(title: title)
        page.image = image
        
        page.descriptionText = description
        page.actionButtonTitle = actionButtonText
        page.alternativeButtonTitle = alternativeButtonText
        page.actionHandler = { (item: BLTNActionItem) in
            item.manager?.dismissBulletin(animated: true)
            self.vibratePhone()
            self.logout()
        }
        page.alternativeHandler = { (item: BLTNActionItem) in
            item.manager?.dismissBulletin(animated: true)
            self.vibratePhone()
        }
        let rootItem: BLTNItem = page
        
        return rootItem
    }
    
    func logout() {
        
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "LoggedIn")
        defaults.set("//", forKey: "token")
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Mitarbeiter").child((ViewController.currentUser?.id!)!).child("token").setValue("//")
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "logintab")
        UIApplication.shared.keyWindow?.rootViewController = loginViewController
        
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
            newViewController = storyBoard.instantiateViewController(withIdentifier: "stoebern_nv")
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
            newViewController = storyBoard.instantiateViewController(withIdentifier: "profile_nc")
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
                newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteldetails_nc")
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
    func createBulletinBoardItem(title: String, description: String, actionButtonText: String, alternativeButtonText: String, image: UIImage) -> BLTNItem {
        let page = BLTNPageItem(title: title)
        page.image = image
        
        page.descriptionText = description
        page.actionButtonTitle = actionButtonText
        page.alternativeButtonTitle = alternativeButtonText
        let rootItem: BLTNItem = page
        
        return rootItem
    }
    func vibratePhone() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    func vibratePhoneMedium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
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
