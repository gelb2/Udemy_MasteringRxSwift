import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//Merge two sequence into one Sequence
//when two sequence calls onNext(), this observable check two sequences and get the latestValue from each two sequence

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let observable = Observable.combineLatest(left, right) { lastLeft, lastRight in
    "\(lastLeft) \(lastRight)"
}

let disposeable = observable.subscribe { value in
    print(value)
}

//45 1
//30 1
//30 1
//30 2
left.onNext(45)
right.onNext(1)
left.onNext(30)
right.onNext(1)
right.onNext(2)

