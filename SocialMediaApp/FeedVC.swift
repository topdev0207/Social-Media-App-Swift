//
//  FeedVC.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 13/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    @IBAction func signOut(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)

        try! FIRAuth.auth()?.signOut()
        
        GIDSignIn.sharedInstance().disconnect()
        print("Sign out")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
}
