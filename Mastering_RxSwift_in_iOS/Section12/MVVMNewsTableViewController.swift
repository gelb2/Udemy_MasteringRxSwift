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
    private var articleListVM: ArticleListViewModel!

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
            .subscribe(onNext: { [weak self] articleResponse in
                let articles = articleResponse?.articles
                self?.articleListVM = ArticleListViewModel(articles ?? [])
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0: self.articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MVVMArticleCell", for: indexPath) as? MVVMArticleCell else { fatalError() }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
}
