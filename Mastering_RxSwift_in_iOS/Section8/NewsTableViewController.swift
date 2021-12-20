//
//  NewsTableViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/19.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    private let newsURLString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=cd1d5fbfb7be4a46bfc824991225619c"
    
    private let disposeBag = DisposeBag()
    
    private var articles = [Article]()
        

    override func viewDidLoad() {
        super.viewDidLoad()
        drawNaviController()
        populateNews()
    }
    
    private func drawNaviController() {
        self.title = "News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .green
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .blue
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.orange]
        
        self.navigationController?.navigationBar.backgroundColor = .red
    }
    
    private func populateNews() {
        let url = URL(string: newsURLString)!
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> [Article]? in
                return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
            }.subscribe(onNext: { [weak self] articles in
                if let articles = articles {
                    self?.articles = articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { fatalError() }
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        
        return cell
    }
}
