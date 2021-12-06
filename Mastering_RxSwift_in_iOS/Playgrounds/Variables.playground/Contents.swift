import UIKit
import RxSwift

var greeting = "Hello, playground"

private let disposeBag = DisposeBag()

//variable is wrapper of behavior subject
//stores it's value and state
//set initial value like a behavior subject
//Absolutely Deprecated, Replaced by using the behavior relay in RxSwift 5.0. you cannot use Variable since RxSwift 5.0

let variable = Variable("initial value")

variable.value = "hello world"

/* output is like this
 next(hello world)
 */
variable.asObservable()
    .subscribe { value in
        print("\(value)")
    }

let variable2 = Variable([String]())
variable2.value.append("item 1")

/* output is like this
 item is next(["item 1"])
 item is next(["item 1", "item 2"])
 */
variable2.asObservable().subscribe { item in
    print("item is \(item)")
}

variable2.value.append("item 2")

//if variable is converted observable (variable.asObservable()), subscription always fired when variable's value is changed
/* output is like this
 adding item 3
 item is next(["item 1", "item 2", "item 3"])
 */
print("adding item 3")
variable2.value.append("item 3")
