//
//  Tasks.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by sokol on 2021/12/16.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Tasks {
    let title: String
    let priority: Priority
}
