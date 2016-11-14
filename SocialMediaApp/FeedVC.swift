//
//  FeedVC.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 13/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func signOut(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)

        try! FIRAuth.auth()?.signOut()
        
        GIDSignIn.sharedInstance().disconnect()
        print("Sign out")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
        
    }
}
