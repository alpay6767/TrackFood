//
//  Filiale.swift
//  Covid Entrance Check
//
//  Created by Alpay Kücük on 21.03.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class Filiale {
    
    var id: String?
    var name: String?
    var pictureURL: String?
    var address: String?
    var zip: String?
    var city: String?
    var lizenz: String?
    var ablaufdatum: String?
    
    
    init(id: String, name: String, pictureURL: String, address: String,zip: String, city: String, lizenz: String, ablaufdatum: String) {
        self.id = id
        self.name = name
        self.pictureURL = pictureURL
        self.address = address
        self.zip = zip
        self.city = city
        self.lizenz = lizenz
        self.ablaufdatum = ablaufdatum
    }
    
    
    init?(snapshot: DataSnapshot) {
        let value = snapshot.value as? [String : AnyObject]
        self.name = value!["name"] as? String
        self.id = value!["id"] as? String
        self.pictureURL = value!["pictureurl"] as? String
        self.address = value!["address"] as? String
        self.zip = value!["zip"] as? String
        self.city = value!["city"] as? String
        self.ablaufdatum = value!["ablaufdatum"] as? String
        self.lizenz = value!["lizenz"] as? String
    }
    
    init() {
        
    }
    
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    
}
