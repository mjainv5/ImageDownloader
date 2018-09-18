//
//  ImagePreviewPresentator.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

class ImagePreviewPresentator: ImagePreviewPresentation {
    let model: ImageModel
    let image: UIImage?
    init(model : ImageModel,image: UIImage?) {
        self.model = model
        self.image = image
    }
}
