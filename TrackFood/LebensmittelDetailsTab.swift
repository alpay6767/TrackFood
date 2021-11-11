//
//  LebensmittelDetailsTab.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import AZDialogView
import Kingfisher

class LebensmittelDetailsTab: UIViewController, UITextFieldDelegate {
    
    static var currentLebensmittel: Lebensmittel?
    
    let modeldata = ModelData()
    
    @IBOutlet weak var bild: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        let url = URL(string: (LebensmittelDetailsTab.currentLebensmittel?.image)!)
        bild.kf.setImage(with: url)
        bild.layer.cornerRadius = bild.bounds.width/2
        bild.clipsToBounds = true
        name.text = LebensmittelDetailsTab.currentLebensmittel?.bezeichnung
        
        self.navigationItem.title = LebensmittelDetailsTab.currentLebensmittel?.bezeichnung
    }

}





