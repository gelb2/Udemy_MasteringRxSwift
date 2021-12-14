import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.skipUntil(trigger)
    .subscribe { value in
        print(value)
    }.disposed(by: disposeBag)

trigger.subscribe { value in
    print(value)
} onError: { error in
    print(error)
} onCompleted: {
    print("oncompleted")
} onDisposed: {
    print("ondisposed")
}.disposed(by: disposeBag)


//Nothing Fired. because skipUntil(trigger) blocks them
subject.onNext("A")
subject.onNext("B")

//Since trigger.onNext() is called, subject get C, D, E Element
trigger.onNext("Trigger 1")
subject.onNext("C")
subject.onNext("D")
subject.onNext("E")

//once trigger.onNext("Trigger 1") called, subject get F, G, H also.
//whether or not, you comment trigger.onNext("Trigger 2")
//trigger.onNext("Trigger 2")

subject.onNext("F")
subject.onNext("G")
subject.onNext("H")
