//
//  ImageCollectionViewCell.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 16/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //MARK:- Outlets
    @IBOutlet weak var flickrImageview: UIImageView!
    
    //MARK:- HelperMethods
    func configure(model: ImageModel) { // Configure Cell
        flickrImageview.setDownloadedImage(with: model.thumbImageUrl, placeholderImage: UIImage(named: "placeholder"), completion: { (image, error) -> (Void) in
        })
    }
}
