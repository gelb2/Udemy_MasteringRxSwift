import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//merge two sequence into one sequence. not in particular order
//order: determined as time that each element emit(arrived to subscriber)

let left = PublishSubject<Int>()
let right = PublishSubject<Int>()

let source = Observable.of(left.asObservable(), right.asObservable())

let observable = source.merge()
observable.subscribe { value in
    print(value)
}.disposed(by: disposeBag)

//5,3,2,1,99
left.onNext(5)
left.onNext(3)
right.onNext(2)
right.onNext(1)
left.onNext(99)

