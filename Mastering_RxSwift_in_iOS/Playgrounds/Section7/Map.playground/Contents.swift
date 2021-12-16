import UIKit
import RxSwift

var greeting = "Hello, playground"
let disposeBag = DisposeBag()

//주어진 조건대로 각 엘리먼트들을 변환한다

Observable.of(1,2,3,4,5)
    .map { $0 * 2 }
    .subscribe { value in
        print("value is \(value)")
    }.disposed(by: disposeBag)

Observable.of(1,2,3,4,5)
    .map { "string num \($0)" }
    .subscribe { value in
        print("value is \(value)")
    }.disposed(by: disposeBag)
