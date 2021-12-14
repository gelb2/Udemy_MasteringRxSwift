import UIKit
import RxSwift

//gets elements until parameter observable call onNext
var greeting = "Hello, playground"
let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.takeUntil(trigger)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("1")
subject.onNext("2")

//"3" is skipped because trigger.onNext("called")
trigger.onNext("X")
subject.onNext("3")


