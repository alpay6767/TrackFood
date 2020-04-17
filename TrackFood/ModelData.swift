//
//  ModelData.swift
//  TrackFood
//
//  Created by Alpay Kücük on 17.04.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit

class ModelData {
    
    var main_menupoints = [MenuPunkt]()
    var lebensmittel_menupoints = [MenuPunkt]()
    var listeansehen_menupoints = [MenuPunkt]()
    var neueLieferung_menupoints = [MenuPunkt]()
    
    
    init() {
        main()
        lebensmittel()
        listeansehen()
        neuelieferung()
    }
    
    func main(){
        let baldablaufend = MenuPunkt(name: "Bald ablaufend", bild: UIImage(named: "baldablaufen")!)
        let lebensmittel = MenuPunkt(name: "Lebensmittel", bild: UIImage(named: "lebensmittel")!)
        let Toilettenpapier = MenuPunkt(name: "Toilettenpapier", bild: UIImage(named: "toilettenpapier")!)
        let besucher = MenuPunkt(name: "Besucher", bild: UIImage(named: "besucher")!)
        
        main_menupoints.append(baldablaufend)
        main_menupoints.append(lebensmittel)
        main_menupoints.append(Toilettenpapier)
        main_menupoints.append(besucher)
        
    }
    
    func lebensmittel(){
          let listeansehen = MenuPunkt(name: "Liste ansehen", bild: UIImage(named: "listeansehen")!)
          let neuelieferung = MenuPunkt(name: "Neue Lieferung", bild: UIImage(named: "neuelieferung")!)
    
          lebensmittel_menupoints.append(listeansehen)
          lebensmittel_menupoints.append(neuelieferung)
      }
    
    func listeansehen(){
        let backwaren = MenuPunkt(name: "Backwaren", bild: UIImage(named: "backwaren")!)
        let obst = MenuPunkt(name: "Obst", bild: UIImage(named: "obst")!)
        let gemüse = MenuPunkt(name: "Gemüse", bild: UIImage(named: "gemüse")!)
        let fleischandfisch = MenuPunkt(name: "Fleisch & Fisch", bild: UIImage(named: "fleisch")!)
        let milchprodukte = MenuPunkt(name: "Milchprodukte", bild: UIImage(named: "milchprodukte")!)
        let teigwaren = MenuPunkt(name: "Teigwaren", bild: UIImage(named: "teigwaren")!)
        let sonstiges = MenuPunkt(name: "Sonstiges", bild: UIImage(named: "sonstiges")!)
        let getränke = MenuPunkt(name: "Getränke", bild: UIImage(named: "getränke")!)
        
        listeansehen_menupoints.append(backwaren)
        listeansehen_menupoints.append(obst)
        listeansehen_menupoints.append(gemüse)
        listeansehen_menupoints.append(fleischandfisch)
        listeansehen_menupoints.append(milchprodukte)
        listeansehen_menupoints.append(teigwaren)
        listeansehen_menupoints.append(sonstiges)
        listeansehen_menupoints.append(getränke)
      }
    
    func neuelieferung(){
          let scannen = MenuPunkt(name: "Scannen", bild: UIImage(named: "scannen")!)
          neueLieferung_menupoints.append(scannen)
      }
    
    
}
