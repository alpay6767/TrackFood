//
//  FilialenVerwaltenTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 18.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import FirebaseDatabase

class FilialenVerwaltenTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
        
    
    @IBOutlet weak var filialencv: UICollectionView!
    @IBOutlet weak var suchentv: UITextField!
    
    let fbhandler = FBHandler()
    var filialenListe = [Filiale]()
    let modeldata = ModelData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filialencv.delegate = self
        filialencv.dataSource = self
        hideKeyboardWhenTappedAround()
        loadFilialenListe()
        suchentv.addTarget(self, action: #selector(FilialenVerwaltenTab.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    
    func loadFilialenListe() {
        
        fbhandler.loadFirmenFromDB() { [self] firmenliste in
             guard let firmenliste = firmenliste else { return }
                
            self.filialenListe = firmenliste
            self.filialenListe.reverse()
            self.filialencv.reloadData()
            
        }
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        var key = textField.text!.lowercased()
        var sorted = filialenListe.sorted {
            if $0.name?.lowercased() == key && $1.name!.lowercased() != key {
                return true
            }
            else if $0.name!.lowercased().hasPrefix(key) && !$1.name!.lowercased().hasPrefix(key)  {
                return true
            }
            else if $0.name!.lowercased().hasPrefix(key) && $1.name!.lowercased().hasPrefix(key)
                && $0.name!.count < $1.name!.count  {
                return true
            }
            else if $0.name!.lowercased().contains(key) && !$1.name!.lowercased().contains(key) {
                return true
            }
            else if $0.name!.lowercased().contains(key) && $1.name!.lowercased().contains(key)
                && $0.name!.count < $1.name!.count {
                return true
            }
            return false
        }
        
        
        self.filialencv?.scrollToItem(at: IndexPath(row: 0, section: 0),
              at: .top,
        animated: true)
        filialenListe = sorted
        filialencv.reloadData()
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width - 15, height: view.bounds.height*0.13
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filialenListe.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentFiliale = filialenListe[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filialencell", for: indexPath) as! FilialenCell
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        cell.anschrift.text = (currentFiliale.name)! + " " + (currentFiliale.address)!
        return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFiliale = filialenListe[indexPath.item]
        FilialenDetailTab.currentFiliale = currentFiliale
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "filialendetailtab") as! FilialenDetailTab
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
      }


}




