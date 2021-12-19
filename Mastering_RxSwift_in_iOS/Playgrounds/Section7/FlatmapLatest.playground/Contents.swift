import UIKit
import RxSwift
import RxCocoa

var greeting = "Hello, playground"
let disposeBag = DisposeBag()

struct Student {
    var score: BehaviorRelay<Int>
}

let john = Student(score: BehaviorRelay<Int>(value: 90))
let mary = Student(score: BehaviorRelay<Int>(value: 95))
let charles = Student(score: BehaviorRelay<Int>(value: 75))

let student = PublishSubject<Student>()

student.asObservable()
    .flatMapLatest { $0.score.asObservable() }
    .subscribe { value in
        print("score is :\(value)")
    }.disposed(by: disposeBag)

/*
 output
 score is :next(90)
 score is :next(44)
 */
student.onNext(john)
john.score.accept(44)

//new element is observed
student.onNext(mary)

//not printed john's score
//because flatMapLatest only observe and emit observable last observable element
//in this case, only mary's score emitted
john.score.accept(22)

//score is :next(1000)
mary.score.accept(1000)

//not printed john's score
john.score.accept(111111111)

//score is :next(20000)
mary.score.accept(20000)

//new element is observed
//score is :next(75)
student.onNext(charles)

//not printed john's score
john.score.accept(100000)
//not printed mary's score
mary.score.accept(200000)
//score is :next(300000)
charles.score.accept(300000)
