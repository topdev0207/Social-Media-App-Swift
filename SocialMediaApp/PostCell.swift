//
//  PostCell.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 14/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var capture: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        
        self.capture.text = post.caption
        self.likesLbl.text = "Likes: \(post.likes)"
        
        if img != nil {
            
            postImg.image = img
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    self.downloadImage(imageUrl: post.imageUrl)
                } else {
                    
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.postId as NSString)
                        }
                    }
                }
            })
        }
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
