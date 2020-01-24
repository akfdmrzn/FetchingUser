//
//  PhotosViewController.swift
//  FetchUser
//
//  Created by Akif Demirezen on 23.01.2020.
//  Copyright © 2020 akif. All rights reserved.
//

import UIKit
import SDWebImage
import ImageViewer_swift

class PhotosViewController:UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    // load a lower resolution images
    var imageList : [PhotoModel] = []{
        didSet{
            
        }
    }
    var images:[UIImage] = []
    var imageURL:[URL] = []{
        didSet{
            self.collectionView.reloadData()
        }
    }
    var albumId : Int?
    lazy var layout = GalleryFlowLayout()
    
    lazy var collectionView:UICollectionView = {
        // Flow layout setup
        let cv = UICollectionView(
            frame: self.containerView.bounds, collectionViewLayout: layout)
        cv.register(
            ThumbCell.self,
            forCellWithReuseIdentifier: ThumbCell.reuseIdentifier)
        cv.dataSource = self
        return cv
    }()
    
    override func loadView() {
        super.loadView()
        self.containerView.addSubview(collectionView)
        self.getPhotos(albumId: self.albumId!)
    }
    
    func getPhotos(albumId : Int){
              
              NetworkClient.performRequest([PhotoModel].self, router: APIRouter.photos, success: { [weak self] (models) in
                self?.imageList = models
                for item in self!.imageList{
                    if albumId == item.albumID{
                        let imageURL = URL.init(string: item.thumbnailURL)
                        if let imageData = try? Data(contentsOf: imageURL!) {
                            DispatchQueue.main.async {
                                self?.images.append(UIImage(data: imageData)!)
                                self?.imageURL.append(imageURL!)
                            }
                        }
                    }
                }
              }) { [weak self] (error) in
               self?.showAlertMsg(msg: error.localizedDescription, finished: {
                   
               })
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
//        SDImageCache.shared.clear(with: .all, completion: nil)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLayout(view.frame.size)
    }
    
    private func updateLayout(_ size:CGSize) {
        if size.width > size.height {
            layout.columns = 4
        } else {
            layout.columns = 3
        }
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(size)
    }
}

extension PhotosViewController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ThumbCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: ThumbCell.reuseIdentifier,
                                 for: indexPath) as! ThumbCell
        cell.imageView.image = images[indexPath.item]
        
        // Setup Image Viewer with [URL]
        cell.imageView.setupImageViewer(
            urls: self.imageURL,
            initialIndex: indexPath.item,
            options: [
                .theme(.dark),
                .rightNavItemTitle("Info", delegate: self)
            ],
            from: self)
        
        return cell
    }
}

extension PhotosViewController:RightNavItemDelegate {
    func imageViewer(_ imageViewer: ImageCarouselViewController, didTapRightNavItem index: Int) {
        print("TAPPED", index)
    }
}

