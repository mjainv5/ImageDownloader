//
//  Constants.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import Foundation

let kPageSize = 50
let kUnknownError = "An Unknown error has occured"
let kNoInternetConnection = "Please check your Internet connection and try again."

let kFlickrAPIKey = "2c621073cb6aa5c12ef5aa14aa4cdcb0"
let kFlickrAPISecret = "db808e1145d70dce"

let kBaseURL = "https://api.flickr.com/services/rest/"

let kSearchURL = "\(kBaseURL)?method=flickr.photos.search&api_key=\(kFlickrAPIKey)&format=json&text=%@&page=%ld"

let kImageURL = "https://farm%@.staticflickr.com/%@/%@_%@_%@.jpg"
