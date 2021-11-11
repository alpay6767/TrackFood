//
//  ProfilTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import AZDialogView

class ProfilTab: UIViewController {
    
    let modeldata = ModelData()
    
    @IBOutlet weak var profile_tv: UITableView!
    @IBOutlet weak var nametv: UILabel!
    @IBOutlet weak var mitarbeitertv: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        nametv.text = (ViewController.currentUser?.username)!
        mitarbeitertv.text = (ViewController.currentFiliale?.name)!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                print("Password ändern")
                break
            case 1:
                print("Nutzername ändern")
                break
            default:
                print("Nichts")
            }
            break
        case 1:
            switch indexPath.row {
            case 0:
                print("Lizenz abfragen")
                break
            default:
                print("Nichts")
            }
            break
        default:
            print("Nichts")
        }
    }


}






