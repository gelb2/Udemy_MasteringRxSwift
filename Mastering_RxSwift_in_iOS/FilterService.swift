//
//  FilterService.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/14.
//

import Foundation
import UIKit
import CoreImage
import RxSwift


class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(image: inputImage) { image in
                observer.onNext(image)
            }
            
            return Disposables.create()
        }
    }
    
    private func applyFilter(image: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: image) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgimg, scale: image.scale, orientation: image.imageOrientation)
                completion(processedImage)
            }
            
        }
    }
}
