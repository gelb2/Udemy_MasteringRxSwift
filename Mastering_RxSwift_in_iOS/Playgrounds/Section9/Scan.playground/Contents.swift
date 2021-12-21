import UIKit
import RxSwift

var greeting = "Hello, playground"

//similar as reduce operator
//when we use reduce, we only get one Value(Result of given closure, formula),
//but scan gives us "middle, unfinished result" also. during given closure run logic(+, -, *, / etc...) multiplly
//so, scan can emit values multiple times

let disposeBag = DisposeBag()

//1
//3
//6
//11
//17
let source = Observable.of(1,2,3,5,6)
source.scan(0, accumulator: +)
    .subscribe { value in
        print(value)
    }.disposed(by: disposeBag)

//1
//2
//6
//30
//180
source.scan(1, accumulator: { first, last in
    return first * last
}).subscribe(onNext: { print($0) }).disposed(by: disposeBag)

//180
source.reduce(1, accumulator: { first, last in
    return first * last
}).subscribe(onNext: { print($0) }).disposed(by: disposeBag)
