//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 11/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var emailText: FancyField!
    @IBOutlet weak var passwordText: FancyField!
    @IBOutlet weak var logOutBtn: FancyButton!
    @IBOutlet weak var signInBtn: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        refreshInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshInterface()
    }
    @IBAction func logOutPressed(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
        logOutBtn.isHidden = true
        signInBtn.isHidden = false
    }
    
    func refreshInterface() {
        
        if let currentUser = GIDSignIn.sharedInstance().currentUser {
            
            print("\(currentUser.profile.name)")
            self.emailText.text = GIDSignIn.sharedInstance().currentUser.profile.email as String
            logOutBtn.isHidden = false
            signInBtn.isHidden = true
            
        } else {
            
            print("There is no user")
        }
    }
}



