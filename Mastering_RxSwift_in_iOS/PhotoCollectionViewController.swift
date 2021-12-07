//
//  PhotoCollectionViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/07.
//

import UIKit
import Photos

class PhotoCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        //request permission
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                //access photos from photo library
            } else {
                
            }
        }
    }
    
}
