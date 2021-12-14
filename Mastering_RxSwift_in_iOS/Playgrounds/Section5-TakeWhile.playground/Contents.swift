import UIKit
import RxSwift

var greeting = "Hello, playground"
let disposeBag = DisposeBag()

//once that particular condition becomes false, it will not give you any more item

//condition( $0 % 2 ==0 ) is false at 7, 8 and 10 are skipped
//output: 2, 4, 6
Observable.of(2,4,6,7,8,10)
    .takeWhile { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)


