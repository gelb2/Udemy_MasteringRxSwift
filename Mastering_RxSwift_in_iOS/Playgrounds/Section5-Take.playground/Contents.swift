import UIKit
import RxSwift

var greeting = "Hello, playground"
let disposeBag = DisposeBag()

//taking some element as you request

//output: 1,2,3
Observable.of(1,2,3,4,5,6,7)
    .take(3)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
