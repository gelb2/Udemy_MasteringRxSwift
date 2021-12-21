import UIKit
import RxSwift

var greeting = "Hello, playground"

//allows you to get the latest value from a particular sequence or a particular control

let disposeBag = DisposeBag()

let button = PublishSubject<String>()
let textField = PublishSubject<String>()

let observable = button.withLatestFrom(textField)
let disposable = observable.subscribe { value in
    print(value)
}

textField.onNext("Sw")
textField.onNext("Swif")
textField.onNext("Swift")
//Swift
//Swift
//only getting the latest Event which was invoked in the textfield
//Sw, Swif are ignored
button.onNext("button 1")
button.onNext("button 2")

//observable gets nothing because button didn't call onNext
textField.onNext("Swift Rock")

button.onNext("button 3")
button.onNext("button 4")
