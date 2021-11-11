//
//  ProfileMenu.swift
//  TrackFood
//
//  Created by Alpay Kücük on 07.11.21.
//  Copyright © 2021 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import BLTNBoard

class ProfileMenu: UITableViewController {
    
    let currentuser = ViewController.currentUser
    let currentFiliale = ViewController.currentFiliale
    
    var bulletinManager : BLTNItemManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let storyBoard: UIStoryboard = UIStoryboard(name: "nutzerVerwalten", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "passwordaenderntab")
                self.navigationController?.pushViewController(newViewController, animated: true)
                break
            default:
                print("Nichts")
            }
            break
        case 1:
            switch indexPath.row {
            case 0:
                
                let page = BLTNPageItem(title: "Lizenz-Info")
                page.image = #imageLiteral(resourceName: "guy2")
                
                page.descriptionText = "Deine aktuelle Lizenz läuft noch bis: " + (self.currentFiliale?.ablaufdatum)!
                page.actionButtonTitle = "Ok"
                page.actionHandler = { (item: BLTNActionItem) in
                    self.vibratePhone()
                    item.manager?.dismissBulletin(animated: true)
                }
                let rootItem: BLTNItem = page
                
                self.bulletinManager = BLTNItemManager(rootItem: rootItem)
                self.bulletinManager!.showBulletin(above: self)
                break
            default:
                print("Nichts")
            }
            break
        case 2:
            if let url = URL(string: "https://food-alarm.jimdosite.com/testen/") {
                UIApplication.shared.open(url)
            }
            break
        default:
            print("Nichts")
        }
    }
    
}
