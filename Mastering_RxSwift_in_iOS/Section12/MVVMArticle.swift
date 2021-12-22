//
//  MVVMArticle.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by pablo.jee on 2021/12/22.
//

import Foundation

struct MVVMArticleResponse: Decodable {
    let articles: [MVVMArticle]
}

struct MVVMArticle: Decodable {
    var title: String?
    var description: String?
}
