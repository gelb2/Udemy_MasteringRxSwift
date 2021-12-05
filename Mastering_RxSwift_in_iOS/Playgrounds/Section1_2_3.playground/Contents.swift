import UIKit
import RxSwift
import RxCocoa

var greeting = "Hello, playground"

//no dispose --> memory leak
private let disposeBag = DisposeBag()

//observable<Int>
var observable = Observable.just(1)

//observable<Int>
var observable2 = Observable.of(1,2,3)

//observable<[Int]>
var observable3 = Observable.of([1,2,3])

//observable<Int>
var observable4 = Observable.from([1,2,3,4,5])

observable4.subscribe { event in
    
    //Int element
    if let value = event.element {
        print(value)
    }
}

observable3.subscribe { event in
    print(event)
    
    //[Int] element
    if let element = event.element {
        print(element)
    }
    
}

observable4.subscribe(onNext: { element in
    print("onNext")
    print(element)
})

//no dispose --> memory leak
let subscription4 = observable4.subscribe(onNext: { element in
    print("onNext : \(element)")
})
subscription4.dispose()

//no dispose --> memory leak
Observable.of("A", "B", "C")
    .subscribe{ print($0) }
    .disposed(by: disposeBag)

//subscribe(구독)을 만드는 법
//1. subscribe 메소드
//2. create 메소드

Observable<String>.create { observable in
    observable.onNext("A")
    observable.onCompleted()
    observable.onNext("???") //Not called Because onCompleted() is already called before
    return Disposables.create()
}
.subscribe(onNext: { value in
    print("onNext: \(value)")
}, onError: {error in
    print(error.localizedDescription)
}, onCompleted: {
    print("completed")
}, onDisposed: {
    print("disposed")
})
.disposed(by: disposeBag)

//subject : they are observable as well as observer
//publish subject, behaviour subject, replay subject, behavirour relay, variable(Deprecated)
//testtesttest
