//
//  FancyView.swift
//  SocialMediaApp
//
//  Created by Patrick Gross on 11/11/2016.
//  Copyright © 2016 Patrick Gross. All rights reserved.
//

import UIKit

class FancyView: UIView {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
}
