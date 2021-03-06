//
//  WeatherViewController.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by pablo.jee on 2021/12/22.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        drawViewController()
        bind()
        // Do any additional setup after loading the view.
    }
    
    private func drawViewController() {
        self.title = "Weather"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .green
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .blue
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        self.navigationController?.navigationBar.backgroundColor = .red
        
        temperatureLabel.textColor = .black
        temperatureLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        
        humidityLabel.textColor = .lightGray
        humidityLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        
        cityNameTextField.returnKeyType = .search
    }
    
    private func bind() {
        //printOutput:
        /*
         s
         se
         seo
         seou
         키보드 내려갈 때
         seoul
         seoul
         seoul
         */
        //이거 왜 키보드 내려갈때 연속으로 호출될까? 좀 이상하지 않음?
        //만약 텍스트 입력 받고, 버튼 누를 필요 없이 자동으로 검색되는 기능 만들려면 클남...
        self.cityNameTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .throttle(1.0, latest: true, scheduler: MainScheduler.instance)
            .debounce(1.0, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { [weak self] in
                self?.cityNameTextField.text
            }.subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) "
            self.humidityLabel.text = "\(weather.humidity) "
        } else {
            self.temperatureLabel.text = "No data"
            self.humidityLabel.text = "NO Data"
        }
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else {
                  return
              }
        
        let resource = Resource<WeatherResult>(url: url)
        
//        let search = URLRequest.load(resource: resource)
//            .observeOn(MainScheduler.instance)
//            .asDriver(onErrorJustReturn: WeatherResult.empty)
        
        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .retry(3) //Retry Request time as you request
            .catchError { error in
                print(error.localizedDescription)
                return Observable.just(WeatherResult.empty)
            }.asDriver(onErrorJustReturn: WeatherResult.empty)
            
        search.map {  "\($0?.main.temp ?? 0.0) F" }
            .drive(self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0?.main.humidity ?? 0.0) H" }
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
