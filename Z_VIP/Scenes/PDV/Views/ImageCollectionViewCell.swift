//
//  ImageCollectionViewCell.swift
//  Z_VIP
//
//  Created by Danh Dang on 11/29/17.
//  Copyright © 2017 com.zalora. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
