//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 11/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var emailText: FancyField!
    @IBOutlet weak var passwordText: FancyField!
    @IBOutlet weak var signInBtn: GIDSignInButton!
    
    var signInCallback: (()->())?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if(error == nil) {
            
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
            
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in

                if let user = user {
                    
                    self.setKeyAndSegue(id: user.uid, provider: credential.provider)
                }
            }
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
    }

    @IBAction func emailSignIn(_ sender: Any) {
        
        if let email = emailText.text, let password = passwordText.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                
                if error == nil {
                
                    print("PAT: User authenticated with Firebase")
                    if let user = user {
                        
                        self.setKeyAndSegue(id: user.uid, provider: user.providerID)
                    }
                    
                } else {
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                    
                        if error != nil {
                            
                            print("PAT: Unable to create account with Firebase: \(error?.localizedDescription)")
                        } else {
                            
                            print("User account created")
                            if let user = user {
                                
                                self.setKeyAndSegue(id: user.uid, provider: user.providerID)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func setKeyAndSegue(id: String, provider: String) {
        
        let userData = ["provider" : provider]
        DataServices.ds.createFirebaseDatabaseUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}



