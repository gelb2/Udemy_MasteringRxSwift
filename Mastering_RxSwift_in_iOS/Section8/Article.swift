//
//  Article.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/20.
//

import Foundation

struct ArticlesList: Decodable {
    var articles: [Article]
}

struct Article: Decodable {
    var title: String?
    var description: String?
}
