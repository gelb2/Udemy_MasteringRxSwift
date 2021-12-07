import UIKit
import RxSwift
import RxCocoa

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//BehaviorRelay is is Rxcocoa
//Initial Value needed

let relay = BehaviorRelay(value: "value 1")

relay.asObservable().subscribe { event in
    print("event is :\(event)")
}

//Cannot assign to property: 'value' is a get-only property
//relay.value = "hello World"

//Set a newValue
relay.accept("hello world")

/* output is like this
 event is :next(value 1)
 event is :next(hello world)
 */

let arrayRelay = BehaviorRelay(value: [String]())

arrayRelay.asObservable().subscribe { event in
    print("array relay event is : \(event)")
}

arrayRelay.accept(["value 1"])

//어떻게 하면 BehaviorRelay가 갖고 있는 배열에 새 데이터를 '추가' 할 수 있을까?
//방법 1
arrayRelay.accept(arrayRelay.value + ["value 2"])

/* output is like this
 array relay event is : next([])
 array relay event is : next(["value 1"])
 array relay event is : next(["value 1", "value 2"])
 */

//방법 2
var tempValue = arrayRelay.value
tempValue.append("value 3")
tempValue.append("value 4")

arrayRelay.accept(tempValue) //output : array relay event is : next(["value 1", "value 2", "value 3", "value 4"])

