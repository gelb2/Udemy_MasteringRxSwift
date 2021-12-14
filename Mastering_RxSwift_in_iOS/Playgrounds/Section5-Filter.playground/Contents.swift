import UIKit

var greeting = "Hello, playground"
import RxSwift

//filter values as given condition
let disposeBag = DisposeBag()

//only 2, 4, 6 are fired
Observable.of(1,2,3,4,5,6,7)
    .filter {  $0 % 2 == 0 }
    .subscribe(onNext: { value in
        print("value is : \(value)")
    }).disposed(by: disposeBag)

