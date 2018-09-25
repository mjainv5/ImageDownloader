//
//  SearchImageTests.swift
//  ImageDownloaderTests
//
//  Created by B0208142 on 24/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import XCTest
@testable import ImageDownloader
class SearchImageTests: XCTestCase {
    
    let registrar = NetworkMockManager()
    var viewController: SearchImageViewController!
    let imageView = UIImageView(frame: CGRect.zero)
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewController = SearchImageRouter.assembleModule(manager: registrar) as! SearchImageViewController
        viewController.presenter.view = nil
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchSearchListSuccess() {
        registrar.responseJSON = .fetchTextListSuccess
        viewController.presenter.userSearchedText(text: "Test")
        XCTAssert(viewController.presenter.numberOfImages() == 100,"List should have image detail")
        
        viewController.presenter.bottomOfTableView()
        print("Hello \(viewController.presenter.numberOfImages())")
        XCTAssert(viewController.presenter.numberOfImages() == 200,"List should have image detail")
        
        viewController.presenter.pushDetailImage(indexPath: IndexPath(row: 0, section: 0), image: nil)
    }
    
    func testFetchSearchListError() {
        registrar.responseJSON = .fetchTextListError
        viewController.presenter.userSearchedText(text: "Test")
        XCTAssert(viewController.presenter.numberOfImages() == 0,"List should have fetch detail.")
    }
    
    func testImageDownload() {
        imageView.setDownloadedImage(with: "https://farm2.staticflickr.com/1942/31040182458_3ee059cb95_t.jpg", placeholderImage: nil) { (image, error) -> (Void) in
            
        }
    }
}
