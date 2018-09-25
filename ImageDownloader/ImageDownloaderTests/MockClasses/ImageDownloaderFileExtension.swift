//
//  ImageDownloaderFileExtension.swift
//  ImageDownloaderTests
//
//  Created by Mohit Jain on 24/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

class ImageDownloaderFileExtension: NSObject {
    func dataFromJSONFile(filePath: String) -> NSData?
    {
        guard let data = openJSONFile(fileName: filePath) else
        {
            return NSData()
        }
        return data
    }
    
    private func openJSONFile(fileName: String) -> NSData?
    {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else
        {
            return nil
        }
        return NSData(contentsOfFile:filePath)
    }
}
