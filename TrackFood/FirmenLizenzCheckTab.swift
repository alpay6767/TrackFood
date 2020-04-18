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
            
            showFailedDialog(message: "Bitte fülle alle Felder aus!")
            
            
        } else {
            if AppDelegate.schauObLizenzCodeGefunden(lizenzcode: firmenlizenzcode.text!) {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "registertab") as! registerTab
                
                newViewController.modalPresentationStyle = .fullScreen
                //or .overFullScreen for transparency
                self.present(newViewController, animated: true, completion: nil)
                
                
            } else {
                showFailedDialog(message: "Lizenzcode nicht gefunden!")
            }
        }

    }
    
    func checkLizenzCode() {
        
    }
    
}
