import UIKit
import RxSwift

var greeting = "Hello, playground"

let disposeBag = DisposeBag()

//at init, you have to pass initial value
//when it is subscribe it emit initial value or last value

let subject = BehaviorSubject(value: "initial value")

//if comment issue 1, called like this
/*
 event is : next(last issue)
 */

//if uncomment issue 1, called like this
/*
 event is : next(last issue)
 event is : next(issue 1)
 */
subject.onNext("last issue")


//event is : next(initial value)
subject.subscribe { event in
    print("event is : \(event)")
}

//event is : next(issue 1)
subject.onNext("issue 1")

/*
 behavior subject is similar with publish subject
 difference is
 1. you will have to emit or it will automatically emit last value that was available
 2.
 */
