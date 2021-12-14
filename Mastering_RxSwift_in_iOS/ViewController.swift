//
//  ViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/04.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var photoImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController
                , let photoCollectionViewController = navC.viewControllers.first as? PhotoCollectionViewController else {
                    return
                }
        photoCollectionViewController.selectedPhoto.subscribe(onNext: { [weak self] photo in
            self?.photoImageView.image = photo
        })
            .disposed(by: disposeBag)
    }


}

