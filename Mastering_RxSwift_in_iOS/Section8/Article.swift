//
//  Article.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/20.
//

import Foundation

struct ArticlesList: Decodable {
    
    static let newsURLString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=cd1d5fbfb7be4a46bfc824991225619c"
    
    var articles: [Article]
}

extension ArticlesList {
    static var all: Resource<ArticlesList> = {
        let url: URL = URL(string: newsURLString)!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    var title: String?
    var description: String?
}
