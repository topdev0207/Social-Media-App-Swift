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
    
    func configureCell(post: Post) {
        
        self.capture.text = post.caption
        self.likesLbl.text = "Likes: \(post.likes)"
        downloadImage(imageUrl: post.imageUrl)
    }
    
    func downloadImage(imageUrl: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: imageUrl)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("\(error)")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.postImg.image = image
            })
            
        }).resume()
    }
}
