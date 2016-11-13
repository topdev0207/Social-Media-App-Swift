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
    @IBOutlet weak var logOutBtn: FancyButton!
    @IBOutlet weak var signInBtn: GIDSignInButton!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        refreshInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        refreshInterface()
    }
    
    func refreshInterface() {
        
        if GIDSignIn.sharedInstance().currentUser != nil {
            
            logOutBtn.isHidden = false
            signInBtn.isHidden = true
            
        } else {
            
            print("There is no user")
        }
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        
        print("Logged out...")
        GIDSignIn.sharedInstance().signOut()
        logOutBtn.isHidden = true
        signInBtn.isHidden = false
    }
    
    @IBAction func emailSignIn(_ sender: Any) {
        
        if let email = emailText.text, let password = passwordText.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                
                if error == nil {
                
                    print("PAT: User authenticated with Firebase")
                    
                } else {
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                    
                        if error != nil {
                            
                            print("PAT: Unable to create account with Firebase: \(error?.localizedDescription)")
                        } else {
                            
                            print("User account created")
                        }
                    }
                }
            }
        }
    }
}



