import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//append two sequence into one sequence

let first = Observable.of(1,2,3,4)
let second = Observable.of(5,6,7,8)

let observable = Observable.concat([first, second])
observable.subscribe(onNext: {
    print($0) //1,2,3,4,5,6,7,8
}).disposed(by: disposeBag)
