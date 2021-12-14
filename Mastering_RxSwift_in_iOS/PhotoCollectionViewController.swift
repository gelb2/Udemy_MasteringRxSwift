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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { fatalError() }
        
        let asset = self.images[indexPath.row]
        
        let manager = PHImageManager.default()
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { image, error in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        
        return cell
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
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } else {
                
            }
        }
    }
    
}
