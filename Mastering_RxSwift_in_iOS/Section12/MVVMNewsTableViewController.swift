//
//  MVVMNewsTableViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by pablo.jee on 2021/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class MVVMNewsTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateNews()
    }
    
    private func drawViewController() {
        self.title = "MVVM Weather"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .green
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .yellow
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
        self.navigationController?.navigationBar.backgroundColor = .cyan
    }
    
    private func populateNews() {
        
        let resource = Resource<MVVMArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=cd1d5fbfb7be4a46bfc824991225619c")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
        
    }
}
