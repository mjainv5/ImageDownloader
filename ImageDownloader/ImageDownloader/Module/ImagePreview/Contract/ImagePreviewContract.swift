//
//  ImagePreviewContract.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

protocol ImagePreviewPresentation: class {
    var model: ImageModel {get}
    var image: UIImage? {get}
}

protocol ImagePreviewWireframe {
}

