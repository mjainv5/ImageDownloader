//
//  ImagePreviewViewController.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    @IBOutlet weak var imageDetailPreview: UIImageView!
    var presenter : ImagePreviewPresentator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = presenter.model.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageDetailPreview.setDownloadedImage(with: presenter.model.largeImageUrl, placeholderImage: imageDetailPreview.image) { (image, error) -> (Void) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
}
