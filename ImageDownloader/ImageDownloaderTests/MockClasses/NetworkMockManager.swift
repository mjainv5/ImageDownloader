//
//  NetworkMockManager.swift
//  ImageDownloaderTests
//
//  Created by Mohit Jain on 24/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit
@testable import ImageDownloader
class NetworkMockManager: NetworkRegistrar {
    
    var responseJSON: SearchTextJSONResponse = .fetchTextListSuccess
    enum SearchTextJSONResponse: Int {
        case fetchTextListSuccess = 0
        case fetchTextListError = 1
    }
    
    func stringRequest(urlString: String, type: RequestType, params: [AnyHashable : Any]?, headers: [String : String]?, handler: @escaping StringResponse) {
        let data = ImageDownloaderFileExtension().dataFromJSONFile(filePath:resonseJSONFILE())
        if let data = data as Data?, let dataString = String(data: data, encoding: String.Encoding.utf8) {
            handler(String(dataString.dropLast()),nil)
        } else {
             handler(nil,invalidRequestError())
        }
    }
    
    //MARK:- Private methods
    private func resonseJSONFILE() -> String {
        switch responseJSON {
        case .fetchTextListSuccess: return "fetchSearchListSuccess"
        case .fetchTextListError: return "fetchSearchListError"
        }
    }
    
    private func invalidRequestError() -> NSError { // Invalid request error
        return NSError(domain:"Empty Error", code:400, userInfo:[NSLocalizedDescriptionKey: "Invaild Request"])
    }
    
}
