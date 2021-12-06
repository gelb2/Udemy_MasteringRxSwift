import UIKit
import RxSwift

var greeting = "Hello, playground"

//emit event based on the buffer size you set

let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("issue 1")
subject.onNext("issue 2")
subject.onNext("issue 3")

/* just last two event called because of buffer size is 2
 event : next(issue 2)
 event : next(issue 3)
 */
subject.subscribe { event in
    print("subscribe 1 : \(event)")
}


/* called like this
 event : next(issue 2)
 event : next(issue 3)
 event : next(issue 4)
 event : next(issue 5)
 event : next(issue 6)
 */
subject.onNext("issue 4")
subject.onNext("issue 5")
subject.onNext("issue 6")

/* called like this
 subscription 2
 event : next(issue 5)
 event : next(issue 6)
 */
print("subscription 2")
subject.subscribe { event in
    print("subscribe 2 : \(event)")
}

//Replay subject means "i will replay last events for the new subscriber (when subject.subscribe { } is called )based on the buffer size
//in this case this subject replay last 2 events when subject.subscribe { event in } called

print("subscribe 3")
subject.subscribe { event in
    print("subscribe 3 : \(event)")
}

subject.onNext("issue 7")
subject.onNext("issue 8")

print("subscribe 4")
subject.subscribe { event in
    print("subscribe 4 : \(event)")
}
