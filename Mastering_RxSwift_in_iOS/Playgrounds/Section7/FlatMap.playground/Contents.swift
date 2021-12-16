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
    .flatMap { $0.score.asObservable() }
    .subscribe { value in
        print("score is :\(value)")
    }.disposed(by: disposeBag)

//score is :next(90)
student.onNext(john)

//score is :next(100)
john.score.accept(100)

//score is :next(95)
student.onNext(mary)

//score is :next(75)
mary.score.accept(75)

//score is :next(55)
john.score.accept(55)
