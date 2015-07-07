//
//  CustomCollectionViewCell.swift
//  CustomCollectionViewLayout
//
//  Created by Donny Wals on 07-07-15.
//  Copyright (c) 2015 Donny Wals. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0, 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
    }
}
