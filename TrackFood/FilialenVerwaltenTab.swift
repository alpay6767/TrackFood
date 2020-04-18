//
//  FilialenVerwaltenTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 18.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

class FilialenVerwaltenTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
        
    
    @IBOutlet weak var filialencv: UICollectionView!
    @IBOutlet weak var suchentv: UITextField!
    
    
    let modeldata = ModelData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filialencv.delegate = self
        filialencv.dataSource = self
        hideKeyboardWhenTappedAround()
        
        suchentv.addTarget(self, action: #selector(FilialenVerwaltenTab.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        var key = textField.text!.lowercased()
        let sorted = AppDelegate.filialenList.sorted {
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
        AppDelegate.filialenList = sorted
        filialencv.reloadData()
        

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: view.bounds.width - 15, height: view.bounds.height*0.17
          )
      }
      
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AppDelegate.filialenList.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentFiliale = AppDelegate.filialenList[indexPath.item]
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filialencell", for: indexPath) as! FilialenCell
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.clipsToBounds = true
        cell.anschrift.text = (currentFiliale.name)! + " " + (currentFiliale.address)! + " " + (currentFiliale.city)!
        cell.bild.downloaded(from: currentFiliale.pictureURL!)
        return cell
          
      }
      
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFiliale = AppDelegate.filialenList[indexPath.item]
        FilialenDetailTab.currentFiliale = currentFiliale
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "filialendetailtab") as! FilialenDetailTab
        self.present(newViewController, animated: true, completion: nil)
        
        
      }


}




