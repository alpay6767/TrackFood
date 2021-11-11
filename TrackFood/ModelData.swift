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
    var adminmode_menupoints = [MenuPunkt]()
    var filialendetails_menupoints = [MenuPunkt]()
    var profile_menupoints = [MenuPunkt]()
    var lebensmitteldetails_menupoints = [MenuPunkt]()
    var unternehmen = [Unternehmen]()
    var citys = [String]()
    var kategories = [String]()
    
    
    init() {
        main()
        lebensmittel()
        listeansehen()
        neuelieferung()
        adminmode()
        filialendetails()
        profile()
        lebensmitteldetails()
        
        initUnternehmen()
        initCitys()
        initkategories()
    }
    
    func main(){
        let baldablaufend = MenuPunkt(name: "Bald ablaufend", bild: UIImage(named: "baldablaufen")!)
        //let lebensmittel = MenuPunkt(name: "Lebensmittel", bild: UIImage(named: "lebensmittel")!)
        //let Toilettenpapier = MenuPunkt(name: "Toilettenpapier", bild: UIImage(named: "toilettenpapier")!)
        //let besucher = MenuPunkt(name: "Besucher", bild: UIImage(named: "besucher")!)
        let meinprofil = MenuPunkt(name: "Mein Profil", bild: UIImage(named: "meinprofil")!)
        
        let listeansehen = MenuPunkt(name: "Liste ansehen", bild: UIImage(named: "listeansehen")!)
        let neuelieferung = MenuPunkt(name: "Neue Lieferung", bild: UIImage(named: "neuelieferung")!)
        let lebensmittelhinzufügen = MenuPunkt(name: "Lebensmittel hinzufügen", bild: UIImage(named: "lebensmittelhinzufügen")!)
        
        main_menupoints.append(baldablaufend)
        //main_menupoints.append(lebensmittel)
        //main_menupoints.append(Toilettenpapier)
        //main_menupoints.append(besucher)
        main_menupoints.append(listeansehen)
        main_menupoints.append(neuelieferung)
        main_menupoints.append(lebensmittelhinzufügen)
        main_menupoints.append(meinprofil)
        
    }
    
    func lebensmittel(){
        let listeansehen = MenuPunkt(name: "Liste ansehen", bild: UIImage(named: "listeansehen")!)
        let neuelieferung = MenuPunkt(name: "Neue Lieferung", bild: UIImage(named: "neuelieferung")!)
        let lebensmittelhinzufügen = MenuPunkt(name: "Lebensmittel hinzufügen", bild: UIImage(named: "lebensmittelhinzufügen")!)
    
        lebensmittel_menupoints.append(listeansehen)
        lebensmittel_menupoints.append(neuelieferung)
        lebensmittel_menupoints.append(lebensmittelhinzufügen)
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
    
    func adminmode() {
        let filialen = MenuPunkt(name: "Filialen", bild: UIImage(named: "filialen")!)
        let finanzen = MenuPunkt(name: "Finanzen", bild: UIImage(named: "finanzen")!)
        adminmode_menupoints.append(filialen)
        //adminmode_menupoints.append(finanzen)
    }
    
    func filialendetails() {
        let lizenzerneuern = MenuPunkt(name: "Lizenzerneuern", bild: UIImage(named: "lizenzerneuern")!)
        let codeerneuern = MenuPunkt(name: "Codeerneuern", bild: UIImage(named: "codeerneuern")!)
        filialendetails_menupoints.append(lizenzerneuern)
        filialendetails_menupoints.append(codeerneuern)
    }
    
    func profile() {
        let profillöschen = MenuPunkt(name: "Profil löschen", bild: UIImage(named: "profillöschen")!)
        profile_menupoints.append(profillöschen)
    }
    
    func lebensmitteldetails() {
        let lebensmittellöschen = MenuPunkt(name: "Löschen", bild: UIImage(named: "löschenbtn")!)
        lebensmitteldetails_menupoints.append(lebensmittellöschen)
    }
    
    func initCitys() {
        
        let city1 = "Essen"
        let city2 = "Dortmund"
        let city3 = "Bonn"
        let city4 = "Düsseldorf"
        let city5 = "Duisburg"
        let city6 = "Köln"
        let city7 = "Bochum"
        let city8 = "Gelsenkirchen"
        let city9 = "Hagen"
        let city10 = "Krefeld"
        let city11 = "Oberhausen"
        let city12 = "Aachen"
        let city13 = "Bielefeld"
        let city14 = "Leverkusen"
        let city15 = "Solingen"
        let city16 = "Wuppertal"
        let city18 = "Bottrop"
        let city19 = "Mülheim an der Ruhr"
        let city20 = "Mönchengladback"
        let city21 = "Herne"
        let city22 = "Remscheid"
        let city23 = "Hamm"
        let city24 = "Neuss"
        let city25 = "Minden"
        let city26 = "Siegen"
        let city27 = "Ratingen"
        let city28 = "Moers"
        let city29 = "Paderborn"
        let city30 = "Bergisch Gladbach"
        let city31 = "Iserlohn"
        let city32 = "Witten"
        let city33 = "Marl"
        let city34 = "Velbert"
        let city35 = "Lünen"
        let city36 = "Düren"
        let city37 = "Recklinghausen"
        let city38 = "Gütersloh"
        let city39 = "Münster"
        let city40 = "Lage"
        let city41 = "Lüdenscheid"
        let city42 = "Lippstadt"
        let city43 = "Castrop-Rauxel"
        let city44 = "Dinslaken"
        let city45 = "Brühl"
        let city46 = "Gladbeck"
        let city47 = "Rheine"
        let city48 = "Bad Berlebung"
        let city49 = "Langenfeld"
        let city50 = "Bocholt"
        let city51 = "Xanten"
        let city52 = "Herfold"
        
        
        citys.append(city1)
        citys.append(city2)
        citys.append(city3)
        citys.append(city4)
        citys.append(city5)
        citys.append(city6)
        citys.append(city7)
        citys.append(city8)
        citys.append(city9)
        citys.append(city10)
        citys.append(city11)
        citys.append(city12)
        citys.append(city13)
        citys.append(city14)
        citys.append(city15)
        citys.append(city16)
        citys.append(city18)
        citys.append(city19)
        citys.append(city20)
        citys.append(city21)
        citys.append(city22)
        citys.append(city23)
        citys.append(city24)
        citys.append(city25)
        citys.append(city26)
        citys.append(city27)
        citys.append(city28)
        citys.append(city29)
        citys.append(city30)
        citys.append(city31)
        citys.append(city32)
        citys.append(city33)
        citys.append(city34)
        citys.append(city35)
        citys.append(city36)
        citys.append(city37)
        citys.append(city38)
        citys.append(city39)
        citys.append(city40)
        citys.append(city41)
        citys.append(city42)
        citys.append(city43)
        citys.append(city44)
        citys.append(city45)
        citys.append(city46)
        citys.append(city47)
        citys.append(city48)
        citys.append(city49)
        citys.append(city50)
        citys.append(city51)
        citys.append(city52)
       
        citys.sort()
        
    }
    
    
    
    
    func initUnternehmen() {
        
        let unternehmen1 = Unternehmen(name: "LIDL", bildurl: "https://static.wixstatic.com/media/760454_631d49eb729c409c9bc6ea198684650f~mv2.png/v1/fill/w_157,h_157,al_c,q_85,usm_0.66_1.00_0.01/Lidl-Logo.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen2 = Unternehmen(name: "EDEKA", bildurl: "https://static.wixstatic.com/media/760454_046e9a793c024204be373ef046e75469~mv2.png/v1/fill/w_159,h_192,al_c,q_85,usm_0.66_1.00_0.01/Logo_Edeka.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen3 = Unternehmen(name: "Tedox", bildurl: "https://static.wixstatic.com/media/760454_5cecc7a8416449e3b2c1d4938a2aee64~mv2.png/v1/fill/w_219,h_157,al_c,q_85,usm_0.66_1.00_0.01/Tedox_logo.png", verkauftKlopapier: false, verkauftLebensmittel: false)
        let unternehmen4 = Unternehmen(name: "Mediamarkt", bildurl: "https://static.wixstatic.com/media/760454_d4132b13a2be4e58a0259debb2d83ef0~mv2.png/v1/fill/w_372,h_124,al_c,q_85,usm_0.66_1.00_0.01/Media_Markt_logo.png", verkauftKlopapier: false, verkauftLebensmittel: false)
        let unternehmen5 = Unternehmen(name: "Saturn", bildurl: "https://static.wixstatic.com/media/760454_bf590f37ea09444bbbae388009c1dfbe~mv2.png/v1/fill/w_345,h_75,al_c,q_85,usm_0.66_1.00_0.01/Saturn-Logo.png", verkauftKlopapier: false, verkauftLebensmittel: false)
        let unternehmen6 = Unternehmen(name: "JD", bildurl: "https://static.wixstatic.com/media/760454_a100a2b4da184d00accce7a5526a5de3~mv2.png/v1/fill/w_180,h_179,al_c,q_85,usm_0.66_1.00_0.01/768px-JD_Sports_logo_svg.png", verkauftKlopapier: false, verkauftLebensmittel: false)
        let unternehmen7 = Unternehmen(name: "McDonals", bildurl: "https://static.wixstatic.com/media/760454_1ae5e718f8de42b2a3b8073c09257fcb~mv2.png/v1/fill/w_180,h_157,al_c,q_85,usm_0.66_1.00_0.01/McDonald_s_Golden_Arches.png", verkauftKlopapier: false, verkauftLebensmittel: false)
        let unternehmen8 = Unternehmen(name: "Toom", bildurl: "https://static.wixstatic.com/media/760454_1582f970c2e34b899d7a858bc1072301~mv2.png/v1/fill/w_361,h_157,al_c,q_85,usm_0.66_1.00_0.01/Toom_Markt.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen9 = Unternehmen(name: "REWE", bildurl: "https://static.wixstatic.com/media/760454_2b4e5734d1ed486eb2861bfae42a85dd~mv2.png/v1/fill/w_333,h_107,al_c,q_85,usm_0.66_1.00_0.01/rewe.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen10 = Unternehmen(name: "Netto", bildurl: "https://static.wixstatic.com/media/760454_d929658795f149e689f721f50f3069a9~mv2.png/v1/fill/w_347,h_124,al_c,q_85,usm_0.66_1.00_0.01/netto.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen11 = Unternehmen(name: "ALDI", bildurl: "https://static.wixstatic.com/media/760454_4f9da11777314e4ea03cc932a7aef37d~mv2.png/v1/fill/w_193,h_231,al_c,q_85,usm_0.66_1.00_0.01/1200px-Aldi_Su%CC%88d_2017_logo_svg.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen12 = Unternehmen(name: "Real", bildurl: "https://static.wixstatic.com/media/760454_5cc90ae3c4b8401ebbc1180c2557b776~mv2.png/v1/fill/w_396,h_138,al_c,q_85,usm_0.66_1.00_0.01/real.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen13 = Unternehmen(name: "Penny", bildurl: "https://static.wixstatic.com/media/760454_f9c4793b45a348e7a8e756462138aeb7~mv2.png/v1/fill/w_225,h_196,al_c,q_85,usm_0.66_1.00_0.01/penny.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        let unternehmen14 = Unternehmen(name: "DM", bildurl: "https://static.wixstatic.com/media/760454_6f3619d8395d4d0285f619ed732a0d0e~mv2.png/v1/fill/w_253,h_165,al_c,q_85,usm_0.66_1.00_0.01/dm.png", verkauftKlopapier: true, verkauftLebensmittel: true)
        
        
        
        unternehmen.append(unternehmen1)
        unternehmen.append(unternehmen2)
        unternehmen.append(unternehmen3)
        unternehmen.append(unternehmen4)
        unternehmen.append(unternehmen5)
        unternehmen.append(unternehmen6)
        unternehmen.append(unternehmen7)
        unternehmen.append(unternehmen8)
        unternehmen.append(unternehmen9)
        unternehmen.append(unternehmen10)
        unternehmen.append(unternehmen11)
        unternehmen.append(unternehmen12)
        unternehmen.append(unternehmen13)
        unternehmen.append(unternehmen14)
        
        
        
        
    }
    
    
    func initkategories() {
        
        let kategorie1 = "Backwaren"
        let kategorie2 = "Obst"
        let kategorie3 = "Gemüse"
        let kategorie4 = "Fleisch & Fisch"
        let kategorie5 = "Milchprodukte"
        let kategorie6 = "Teigwaren"
        let kategorie7 = "Sonstiges"
        let kategorie8 = "Getränke"
        
        kategories.append(kategorie1)
        kategories.append(kategorie2)
        kategories.append(kategorie3)
        kategories.append(kategorie4)
        kategories.append(kategorie5)
        kategories.append(kategorie6)
        kategories.append(kategorie7)
        kategories.append(kategorie8)
    }
    
    
}
