//
//  FilialenDetailTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import AZDialogView
import BLTNBoard

class FilialenDetailTab: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    static var currentFiliale: Filiale?
    let modeldata = ModelData()
    
    var bulletinManager : BLTNItemManager?
    
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
        updateFilialenDetails()
        self.navigationItem.title = FilialenDetailTab.currentFiliale?.name
    }
    
    func updateFilialenDetails() {
        anschrift.text = (FilialenDetailTab.currentFiliale?.name)!
        lizenzcode.text = FilialenDetailTab.currentFiliale?.lizenz
        ablaufdatum.text = FilialenDetailTab.currentFiliale?.ablaufdatum
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
        
        switch currentMenuPoint.name {
        case "Lizenzerneuern":
            askToRenewLicense()
            break
        case "Codeerneuern":
            askToGenerateNewLicenseKey()
            break
        default:
            print("Default")
            break
        }
        
      }
    
    
    func askToRenewLicense() {
        let page = BLTNPageItem(title: "Lizenz erneuern?")
        page.image = #imageLiteral(resourceName: "guy1")
        
        page.descriptionText = "Willst du die Lizenz wirklich erneuern? Sie wird um einen Monat verlängert!"
        page.actionButtonTitle = "erneuern"
        page.actionHandler = { (item: BLTNActionItem) in
            self.vibratePhone()
            item.manager?.dismissBulletin(animated: true)
            //MARK: renew license:
            FilialenDetailTab.currentFiliale?.renewLicensForAMonth()
            self.updateFilialenDetails()
        }
        let rootItem: BLTNItem = page
        
        self.bulletinManager = BLTNItemManager(rootItem: rootItem)
        self.bulletinManager!.showBulletin(above: self)
        
    }
    
    func askToGenerateNewLicenseKey() {
        let page = BLTNPageItem(title: "Lizenzschlüssel generieren?")
        page.image = #imageLiteral(resourceName: "guy1")
        
        page.descriptionText = "Willst du wirklich einen neuen Schlüssel generieren?"
        page.actionButtonTitle = "generieren"
        page.actionHandler = { (item: BLTNActionItem) in
            self.vibratePhone()
            item.manager?.dismissBulletin(animated: true)
            //MARK: generate new license key:
            FilialenDetailTab.currentFiliale?.renewLicenseKey()
            self.updateFilialenDetails()
        }
        let rootItem: BLTNItem = page
        
        self.bulletinManager = BLTNItemManager(rootItem: rootItem)
        self.bulletinManager!.showBulletin(above: self)
        
    }

}




