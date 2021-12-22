//
//  MVVMNewsTableViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by pablo.jee on 2021/12/22.
//

import UIKit

class MVVMNewsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawViewController()
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
}
