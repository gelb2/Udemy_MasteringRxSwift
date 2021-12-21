import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//take one sequence and reduce it down to one particular value

let observable = Observable.of(1,2,3)
observable.reduce(0, accumulator: +)
    .subscribe { value in
        print(value) //6
    }.disposed(by: disposeBag)

observable.reduce(0, accumulator: {
    summary, newValue in
    return summary + newValue
}).subscribe { value in
    print(value) //6
}.disposed(by: disposeBag)

observable.reduce(-10, accumulator: {
    summary, newValue in
    return summary - newValue
}).subscribe { value in
    print(value) // -16
}.disposed(by: disposeBag)

observable.reduce(10, accumulator: {
    summary, newValue in
    return summary * newValue
}).subscribe { value in
    print(value) // 60
}.disposed(by: disposeBag)
