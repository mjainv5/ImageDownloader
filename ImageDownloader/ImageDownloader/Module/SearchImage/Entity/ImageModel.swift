//
//  ImageModel.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 16/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import Foundation

struct ImageModel {
    
    //MARK:- Varibales
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: String
    let title: String
    let ispublic: Bool
    let isfriend: Bool
    let isfamily: Bool
    var thumbImageUrl: String { // url for thumb image
        get {
            return String(format: kImageURL, farm, server, id, secret, "t")
        }
    }
    var largeImageUrl: String { // url for large image
        get {
            return String(format: kImageURL, farm, server, id, secret, "b")
        }
    }
    
    //MARK:- Init methods
    init(response: [AnyHashable : Any]) {
        id = response.getStringForKey("id")
        owner = response.getStringForKey("owner")
        secret = response.getStringForKey("secret")
        server = response.getStringForKey("server")
        farm = response.getStringForKey("farm")
        title = response.getStringForKey("title")
        ispublic = response.getBoolForKey("ispublic")
        isfriend = response.getBoolForKey("isfriend")
        isfamily = response.getBoolForKey("isfamily")
    }
}
