//
//  ViewController.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

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
        case "Lebensmittel":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteltab") as! LebensmittelTab
            break
        case "Mein Profil":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "profiltab") as! ProfilTab
            break
        case "Bald ablaufend":
            newViewController = storyBoard.instantiateViewController(withIdentifier: "baldablaufendtab") as! baldAblaufendTab
            break
        default:
            newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteltab") as! LebensmittelTab
            break
        }
        
        self.present(newViewController!, animated: true, completion: nil)
         
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
