//
//  Enums.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import Foundation

enum CallBackType {
    case reload
    case showLoader
    case hideLoader
    case showError(error: String)
}
