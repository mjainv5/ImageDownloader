
//
//  SearchImageViewController.swift
//  ImageDownloader
//
//  Created by Mohit Jain on 14/09/18.
//  Copyright © 2018 Mohit Jain. All rights reserved.
//

import UIKit

class SearchImageViewController: UIViewController {

    var presenter : SearchImagePresentation!
    private var searchBarController: UISearchController!
    private let numberOfRows: CGFloat = 3.0
    private var selectedFrame : CGRect?
    private var navigationInteractor : NavigationInteractor?
    private var selectedImage:UIImage?
    
    @IBOutlet weak var collectionViewImages: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSearchController()
    }
    
    private func setupSearchController() { // Setup search bar and search controller
        searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.enablesReturnKeyAutomatically = true
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupNavigation() { // update navigation bar
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.delegate = self
    }
}

//MARK:- UISearchControllerDelegate, UISearchBarDelegate
extension SearchImageViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.userSearchedText(text: searchBar.text)
        searchBarController.searchBar.resignFirstResponder()
    }
    
}

extension SearchImageViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? ImageCollectionViewCell,let model = presenter.modelImage(indexPath: indexPath) else {
            return
        }
        cell.configure(model: model)
        if indexPath.row == (presenter.numberOfImages() - 1) {
            presenter.bottomOfTableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width)/numberOfRows, height: (collectionView.bounds.width)/numberOfRows)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        self.searchBarController.isActive = false
        perform(#selector(pushDetailView), with: indexPath, afterDelay: 0.01)
    }
    
    @objc func pushDetailView(indexPath: IndexPath){
        guard let cell = collectionViewImages.cellForItem(at: indexPath) as? ImageCollectionViewCell else {
            return
        }
        self.selectedImage = cell.flickrImageview.image
        presenter.pushDetailImage(indexPath: indexPath, image: selectedImage)
      
    }
}

extension SearchImageViewController: SearchImageView {
    func reloadTable() {
        collectionViewImages.reloadData()
    }
    
    func showError() {
        //handling error
    }
}

extension SearchImageViewController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = navigationInteractor else { return nil }
        return ci.transitionInProgress ? navigationInteractor : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        guard let selectedImage = selectedImage else { return nil}
        
        switch operation {
        case .push:
            self.navigationInteractor = NavigationInteractor(attachTo: toVC)
            return NavigationAnimator(duration: TimeInterval(UINavigationControllerHideShowBarDuration), isPresenting: true, originFrame: frame, image: selectedImage)
        default:
            return NavigationAnimator(duration: TimeInterval(UINavigationControllerHideShowBarDuration), isPresenting: false, originFrame: frame, image: selectedImage)
        }
    }
}
