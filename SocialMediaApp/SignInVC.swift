//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 11/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var emailText: FancyField!
    @IBOutlet weak var passwordText: FancyField!
    @IBOutlet weak var signInBtn: GIDSignInButton!
    
        
    override func viewDidLoad() {
        
        super.viewDidLoad()

        GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().uiDelegate = self
        
}
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    @IBAction func emailSignIn(_ sender: Any) {
        
        if let email = emailText.text, let password = passwordText.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                
                if error == nil {
                
                    print("PAT: User authenticated with Firebase")
                    if let user = user {
                       KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                       self.performSegue(withIdentifier: "goToFeed", sender: nil)
                    }
                    
                } else {
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                    
                        if error != nil {
                            
                            print("PAT: Unable to create account with Firebase: \(error?.localizedDescription)")
                        } else {
                            
                            print("User account created")
                            if let user = user {
                                KeychainWrapper.standard.set(user.uid, forKey: KEY_UID)
                                self.performSegue(withIdentifier: "goToFeed", sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
}



