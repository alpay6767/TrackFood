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
import Kingfisher

class LebensmittelSearchTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    @IBOutlet weak var lebensmittelsearchcv: UICollectionView!
    
    let modeldata = ModelData()
    var currentList = [Lebensmittel]()
    static var currentcat: String?
    let fbhandler = FBHandler()
    @IBOutlet weak var suchenTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lebensmittelsearchcv.delegate = self
        lebensmittelsearchcv.dataSource = self
        hideKeyboardWhenTappedAround()
        loadLebensmittelliste()
        suchenTf.delegate = self
        suchenTf.addTarget(self, action: #selector(FilialenVerwaltenTab.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        var key = textField.text!.lowercased()
        var sorted = currentList.sorted {
            if $0.bezeichnung?.lowercased() == key && $1.bezeichnung!.lowercased() != key {
                return true
            }
            else if $0.bezeichnung!.lowercased().hasPrefix(key) && !$1.bezeichnung!.lowercased().hasPrefix(key)  {
                return true
            }
            else if $0.bezeichnung!.lowercased().hasPrefix(key) && $1.bezeichnung!.lowercased().hasPrefix(key)
                && $0.bezeichnung!.count < $1.bezeichnung!.count  {
                return true
            }
            else if $0.bezeichnung!.lowercased().contains(key) && !$1.bezeichnung!.lowercased().contains(key) {
                return true
            }
            else if $0.bezeichnung!.lowercased().contains(key) && $1.bezeichnung!.lowercased().contains(key)
                && $0.bezeichnung!.count < $1.bezeichnung!.count {
                return true
            }
            return false
        }
        
        
        self.lebensmittelsearchcv?.scrollToItem(at: IndexPath(row: 0, section: 0),
              at: .top,
        animated: true)
        currentList = sorted
        lebensmittelsearchcv.reloadData()
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func loadLebensmittelliste() {
        
        fbhandler.loadLebensmittelFromDBWithCategoriy(currentkategorie: LebensmittelSearchTab.currentcat!) { [self] lebensmittelliste in
             guard let lebensmittelliste = lebensmittelliste else {
                return
                
            }
                
            self.currentList = lebensmittelliste
            self.currentList.reverse()
            self.lebensmittelsearchcv.reloadData()
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width, height: 50
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentList.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentLebensmittel = currentList[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lebensmittelcell", for: indexPath) as! LebensmittelCell
        let url = URL(string: currentLebensmittel.image!)
        cell.bild.kf.setImage(with: url)
        cell.name.text = currentLebensmittel.bezeichnung!
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        cell.bild.layer.cornerRadius = 10
        cell.bild.clipsToBounds = true
          return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentLebensmittel = currentList[indexPath.item]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        LebensmittelDetailsTab.currentLebensmittel = currentLebensmittel
        let newViewController: UIViewController?
            newViewController = storyBoard.instantiateViewController(withIdentifier: "lebensmitteldetailstab") as! LebensmittelDetailsTab
        self.navigationController?.pushViewController(newViewController!, animated: true)
    }

}
