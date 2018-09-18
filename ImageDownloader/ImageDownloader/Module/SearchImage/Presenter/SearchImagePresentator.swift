//
//  SearchImagePresentator.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

class SearchImagePresentator: SearchImagePresentation {
    weak var view: SearchImageView?
    var interactor: SearchImageUseCase!
    var router: SearchImageWireframe!
    
    private var pageNo = 1
    private var totalPages = 1
    private var searchedText = ""
    private var arrayImages: [ImageModel] = []
    
    func numberOfImages() -> Int {
        return arrayImages.count
    }
    
    func modelImage(indexPath : IndexPath) -> ImageModel? {
        return arrayImages.indices.contains(indexPath.row) ? arrayImages[indexPath.row] : nil
    }
    
    func userSearchedText(text: String?) {
        guard let text = text, text.count > 0 else {
            return
        }
        pageNo = 1
        totalPages = 1
        searchedText = text
        arrayImages.removeAll()
        getImages()
    }
    
    func bottomOfTableView() {
        if pageNo < totalPages {
            pageNo += 1
        }
        getImages()
    }
    
    private func getImages() {
        interactor.fetchResult(searchText: searchedText, pageNo: pageNo)
    }
    
    func pushDetailImage(indexPath: IndexPath, image: UIImage?) {
        let model = arrayImages[indexPath.row]
        router.pushImageDetailViewController(model: model, image: image)
    }
}

extension SearchImagePresentator: SearchImageInteractorOutput {
    func fetchedImageArray(arrayImagesResult: [ImageModel], totalPages: Int) {
        self.arrayImages.append(contentsOf: arrayImagesResult)
        self.totalPages = totalPages
        view?.reloadTable()
    }
    
    func fetchedImageError(errorMessage: String) {
        router.showError(error: errorMessage)
        view?.showError()
    }
}
