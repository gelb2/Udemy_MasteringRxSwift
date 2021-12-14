import UIKit
import RxSwift

var greeting = "Hello, playground"

//particular value at index
//similar as array
//let value = eventsArray[2]

let strikes = PublishSubject<String>()
let disposeBag = DisposeBag()

strikes.elementAt(2)
    .subscribe(onNext: { element in
        print("your are out : \(element)")
    }).disposed(by: disposeBag)

//Subscription never called because elements are just two
strikes.onNext("X")
strikes.onNext("Y")

//Subscription called because element are three
//your are out : Z
strikes.onNext("Z")

//Subscription called because element are three
//your are out : Z
strikes.onNext("A")
