import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//skip elements as many as you set

//First Three items are skipped
//output: D, E, F
Observable.of("A", "B", "C", "D", "E", "F")
    .skip(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

