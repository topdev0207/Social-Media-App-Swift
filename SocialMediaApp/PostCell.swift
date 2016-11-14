//
//  PostCell.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 14/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var capture: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
}
