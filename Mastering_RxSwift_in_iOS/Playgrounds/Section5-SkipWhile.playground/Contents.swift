import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//output: 3,4,4
Observable.of(2,2,3,4,4)
    .skipWhile { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

//output: 3,2,2,2,2,2,3,4,4
Observable.of(2,2,2,2,3,2,2,2,2,2,3,4,4)
    .skipWhile { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
