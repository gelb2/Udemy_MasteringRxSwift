//
//  PhotoCollectionViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/07.
//

import UIKit
import Photos

class PhotoCollectionViewController: UICollectionViewController {
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        //request permission
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                //access photos from photo library
                let asset = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                asset.enumerateObjects { asset, count, stop in
                    self?.images.append(asset)
                }
                
                //sort in reversed order
                self?.images.reverse()
//                self?.collectionView.reloadData()
            } else {
                
            }
        }
    }
    
}
