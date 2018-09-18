
//
//  SearchImageInteractor.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

class SearchImageInteractor: SearchImageUseCase {
    weak var output: SearchImageInteractorOutput?
    
    private let manager: NetworkManager
    
    init(manager: NetworkManager = NetworkManager.shared) {
        self.manager = manager
    }
    
    func fetchResult(searchText: String,pageNo: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard (Reachability()?.currentReachabilityStatus != .notReachable) else {
            output?.fetchedImageError(errorMessage: kNoInternetConnection)
            return
        }
        manager.stringRequest(urlString: getFormattedURL(searchText: searchText, pageNo: pageNo), type: RequestType.get) { [weak self] (stringResponse, error) -> (Void) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
            self?.parseData(response: self?.getJSON(stringResponse: stringResponse), error: error)
        }
    }
    
    private func getErrorMessage(response: [AnyHashable : Any]?, error: Error?) -> String? { // check for error response
        var errorMsg: String?
        if let error = error {
            errorMsg = error.localizedDescription
        } else if let response = response {
            if response.getStringForKey("stat").lowercased() != "ok" {
                let msg = response.getStringForKey("message")
                errorMsg = msg.isEmpty ? kUnknownError : msg
            }
        }
        return errorMsg
    }
    
    private func getJSON(stringResponse: String?) -> [AnyHashable: Any]? { // convert string to JSON
        var response : [AnyHashable: Any]?
        if let stringResponse = stringResponse {
            var dataReponnse = stringResponse.replacingOccurrences(of: "jsonFlickrApi(", with: "")
            dataReponnse = String(dataReponnse.dropLast())
            do {
                if let data = dataReponnse.data(using: String.Encoding.utf8),
                    let jsonDict = try JSONSerialization.jsonObject(with: data) as? [AnyHashable: Any] {
                    response = jsonDict
                }
            } catch {
                debugPrint(error.localizedDescription)
                output?.fetchedImageError(errorMessage: error.localizedDescription)
            }
        }
        return response
    }
    
    private func parseData(response: [AnyHashable : Any]?, error: Error?) { // parse data and add to data models
        if let error = getErrorMessage(response: response, error: error) {
            output?.fetchedImageError(errorMessage: error)
        } else if let photos = response?["photos"] as? [AnyHashable : Any] {
            var totalPages = 1
            if let pages = photos["pages"] as? Int {
                totalPages = pages
            }
            
            if let photoArr = photos["photo"] as? [[AnyHashable : Any]] {
                var dataSet = [ImageModel]()
                for item in photoArr {
                    dataSet.append(ImageModel(response: item))
                }
                output?.fetchedImageArray(arrayImagesResult: dataSet, totalPages: totalPages)
            }
        }
    }
    
    //MARK:- Helper Methods
    private func getFormattedURL(searchText: String,pageNo: Int) -> String { // Format Url
        return String(format: kSearchURL,searchText,pageNo)
    }
}
