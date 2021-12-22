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
    }
    
    private func bind() {
        self.cityNameTextField.rx.value
            .subscribe(onNext: { city in
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
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance) //Making Sure event is observed on Main Thread, not background Thread
            .catchErrorJustReturn(WeatherResult.empty)
            .subscribe(onNext: { [weak self] value in
                let weather = value?.main
                self?.displayWeather(weather)
            })
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
