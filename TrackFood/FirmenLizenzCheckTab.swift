//
//  FirmenLizenzCheckTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 18.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

class FirmenLizenzCheckTab: UIViewController {
    
    @IBOutlet weak var firmenlizenzcode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func weiterbtn(_ sender: Any) {

        if firmenlizenzcode.text!.isEmpty {
            
                showBeautyfulFailedDialog(title: "Lizenz fehlt", description: "Bitte gib eine gültige Lizenz ein!")
            
        } else {
            
            let fbhandler = FBHandler()
            
            fbhandler.checkFirmenLizenz(currentLizenz: firmenlizenzcode.text!) { authentificated,foundFiliale  in
                 guard let authentificated = authentificated else { return }
                guard let foundFiliale = foundFiliale else {return}
            
            
                if (authentificated) {
                    registerTab.currentFiliale = foundFiliale
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "registertab") as! registerTab
                    
                    newViewController.modalPresentationStyle = .fullScreen
                    //or .overFullScreen for transparency
                    self.present(newViewController, animated: true, completion: nil)
                } else {
                    self.showBeautyfulFailedDialog(title: "Lizenz Fehler", description: "Die angegebene Lizenz wurde nicht gefunden. Bitte kontaktiere deine Filiale!")
                }
            }

        }
    }

}
