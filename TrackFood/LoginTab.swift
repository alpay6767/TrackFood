//
//  loginTab.swift
//  CallOfInfo
//
//  Created by Alpay Kücük on 13.05.20.
//  Copyright © 2020 Alpay Kücük. All rights reserved.
//

import UIKit
import PMAlertController
import FirebaseDatabase
import NVActivityIndicatorView

class LoginTab: UIViewController {
    @IBOutlet weak var username_eingabe: UITextField!
    
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var password_eingabe: UITextField!
    
    @IBOutlet weak var ladebalken: NVActivityIndicatorView!
    @IBOutlet weak var noaccountbtn: UIButton!
    
    let fbhandler = FBHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        
        
    }
    
    fileprivate func skiplogin() {
            let user = User(username: "notloggedin")
            ViewController.currentUser = user
            let mainvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gamestab")
            mainvc.modalPresentationStyle = .fullScreen
            self.present(mainvc, animated: true) {}
        
    }
    
    @IBAction func skip(_ sender: Any) {
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations:  {
            
            self.username_eingabe.transform = CGAffineTransform(translationX: 0, y: 60)
            self.password_eingabe.transform = CGAffineTransform(translationX: 0, y: 60)
            self.loginbtn.transform = CGAffineTransform(translationX: 0, y: 60)
            self.noaccountbtn.transform = CGAffineTransform(translationX: 0, y: 60)
            
            
            
        }) { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations:  {
                
                self.username_eingabe.transform = CGAffineTransform(translationX: 0, y: 0)
                self.password_eingabe.transform = CGAffineTransform(translationX: 0, y: 0)
                self.loginbtn.transform = CGAffineTransform(translationX: 0, y: 0)
                self.noaccountbtn.transform = CGAffineTransform(translationX: 0, y: 0)
                
                
            }) { (_) in
                
                
                self.skiplogin()
                
            }
        }
 
 

    }
    @IBAction func register(_ sender: Any) {
        let mainvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "lizenz_nc")
        self.present(mainvc, animated: true) {}
        
    }
    
    fileprivate func loginlogin() {
        if (username_eingabe.text == "Alpay" && password_eingabe.text == "Hallo123") {
            let mainvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adminmodetab")
            mainvc.modalPresentationStyle = .fullScreen
            self.present(mainvc, animated: true) {}
            
        } else {
            ladebalken.startAnimating()
            checkLogin(username: username_eingabe.text!, password: password_eingabe.text!)
        }
        
        
    }
    
    @IBAction func login(_ sender: Any) {
        
        if username_eingabe.text!.isEmpty || password_eingabe.text!.isEmpty{
            showLoginFailedAlert()
        } else {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations:  {
                
                self.username_eingabe.transform = CGAffineTransform(translationX: 0, y: 60)
                self.password_eingabe.transform = CGAffineTransform(translationX: 0, y: 60)
                self.loginbtn.transform = CGAffineTransform(translationX: 0, y: 60)
                self.noaccountbtn.transform = CGAffineTransform(translationX: 0, y: 60)
                
                
                
            }) { (_) in
                
                
                self.loginlogin()
            }
            
        }
    }
    
    func checkLogin(username: String, password: String) {
        
        fbhandler.checkUserCredentials(username: username, password: password) { authentificated,foundUser  in
             guard let authentificated = authentificated else { return }
            guard let foundUser = foundUser else {return}
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations:  {
                
                
                self.username_eingabe.transform = CGAffineTransform(translationX: 0, y: 0)
                self.password_eingabe.transform = CGAffineTransform(translationX: 0, y: 0)
                self.loginbtn.transform = CGAffineTransform(translationX: 0, y: 0)
                self.noaccountbtn.transform = CGAffineTransform(translationX: 0, y: 0)
                
                
            }) { (_) in
                
                if (authentificated) {
                    
                    self.fbhandler.saveUserToDefaults(user: foundUser)
                    
                    ViewController.currentUser = foundUser
                    
                    self.fbhandler.getFirmaMitFirmenID(currentid: foundUser.filialenid!) { authentificated, foundFiliale in
                        guard let authentificated = authentificated else {
                            return
                        }
                        guard let foundFiliale = foundFiliale else {
                            return
                        }
                        
                        if (authentificated) {
                            ViewController.currentFiliale = foundFiliale
                            if (foundUser.username == "Alpay" && foundUser.password == "Hallo123") {
                                let mainvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "adminmodetab")
                                mainvc.modalPresentationStyle = .fullScreen
                                self.present(mainvc, animated: true) {}
                            } else {
                                let mainvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home")
                                mainvc.modalPresentationStyle = .fullScreen
                                self.present(mainvc, animated: true) {}
                            }
                            
                            print("Eingeloggt: " + foundUser.username!)
                        }
                        
                    }
                } else {
                    self.showLoginFailedAlert()
                }
                
                self.ladebalken.stopAnimating()
                
            }
            
        }
        
    }
    
    func showLoginFailedAlert() {
        let alertVC = PMAlertController(title: "Login didn't work!", description: "Please check your entries", image: UIImage(named: "missinglogo"), style: .alert)
        
        alertVC.alertTitle.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        alertVC.dismissWithBackgroudTouch = true
        alertVC.gravityDismissAnimation = true
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
        
        }))
        

        self.present(alertVC, animated: true, completion: nil)
    }
    
    


}

extension UIViewController {
    
    
    func showBeautyfulFailedDialog(title: String, description: String) {
        let alertVC = PMAlertController(title: title, description: description, image: UIImage(named: "missinglogo"), style: .alert)
        
        alertVC.alertTitle.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        alertVC.dismissWithBackgroudTouch = true
        alertVC.gravityDismissAnimation = true
        
        alertVC.addAction(PMAlertAction(title: "OK", style: .default, action: { () in
        
        }))
        

        self.present(alertVC, animated: true, completion: nil)
    }
    
}

