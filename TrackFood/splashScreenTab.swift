//
//  splashscreenTab.swift
//  CallOfInfo
//
//  Created by Alpay Kücük on 25.05.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import Foundation
import UIKit
import RevealingSplashView


class splashScreenTab: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "logoheader")!, iconInitialSize: CGSize(width: 252, height: 147), backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))

        
        revealingSplashView.animationType = SplashAnimationType.swingAndZoomOut
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)

        //Starts animation
        revealingSplashView.startAnimation(){
            
            let defaults = UserDefaults.standard
            let loggedIn = defaults.bool(forKey: "LoggedIn")
            
            
            if(loggedIn) {
                ViewController.currentUser = AppDelegate.getUserFromDefaults()
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "home") as! ViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            } else {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "logintab") as! LoginTab
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
                
            }
            
        }

    }
    
    
}
