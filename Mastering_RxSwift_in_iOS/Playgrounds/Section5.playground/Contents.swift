import UIKit
import RxSwift
import RxCocoa

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

let strikes = PublishSubject<String>()

strikes
    .ignoreElements()
    .subscribe { event in
        print("subscricption is called")
    }.disposed(by: disposeBag)

//event won't fired because ignoreElements() filters events
strikes.onNext("A")

//event called
//so ignoreElement() is helpful when you don't care about actual event
strikes.onCompleted()
