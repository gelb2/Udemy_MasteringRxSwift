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
    
    @IBOutlet weak var applyFilterButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //NavigationItem, BarButtonItem Color
        self.navigationController?.navigationBar.tintColor = .red
        
        //이건 왜 안되지...
        self.navigationController?.navigationBar.barTintColor = .yellow
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .red
        
        //NavigationController Background Color
//        /rgb(162, 155, 254)
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.yellow]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.yellow]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 162 / 255, green: 155 / 255, blue: 254 / 255, alpha: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CameraFilter" {
            guard let navC = segue.destination as? UINavigationController
                    , let photoCollectionViewController = navC.viewControllers.first as? PhotoCollectionViewController else {
                        return
                    }
            photoCollectionViewController.selectedPhoto.subscribe(onNext: { [weak self] photo in
                DispatchQueue.main.async {
                    self?.updateUI(with: photo)
                }
            })
                .disposed(by: disposeBag)
        } else if segue.identifier == "TodoList" {
            
        }
    }
    
    private func updateUI(with image: UIImage) {
        photoImageView.image = image
    }
    
    @IBAction func applyFilterImage() {
        guard let sourceImage = photoImageView.image else { return }

        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext: { [weak self] image in
                DispatchQueue.main.async {
                    self?.photoImageView.image = image
                }
            })
            .disposed(by: disposeBag)
        
    }


}

