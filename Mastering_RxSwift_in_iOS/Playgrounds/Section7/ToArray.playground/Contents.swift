import UIKit
import RxSwift
import RxCocoa

var greeting = "Hello, playground"
/*
 Transforming operators allow us to change the observable data into a new sequence, transform it into a sequence that we are looking for.
 */

let disposeBag = DisposeBag()
let relay = BehaviorRelay<[Int]>(value: [])

Observable.of(1,2,3,4,5)
    .toArray()
    .subscribe(onNext: { value in
        print(value)
        relay.accept(value)
    }).disposed(by: disposeBag)

relay.subscribe { value in
    print("value is \(value)")
}.disposed(by: disposeBag)


