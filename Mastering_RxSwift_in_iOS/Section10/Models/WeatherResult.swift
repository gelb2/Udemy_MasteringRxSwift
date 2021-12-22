//
//  WeatherResult.swift
//  Mastering_RxSwift_in_iOS
//
//  Created by pablo.jee on 2021/12/22.
//

import Foundation

struct WeatherResult: Decodable {
    let main: Weather
}

extension WeatherResult {
    //EmptyWeather
    static var empty: WeatherResult {
        return WeatherResult(main: Weather(temp: 0.0, humidity: 0.0))
    }
}

struct Weather: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case ondo = "tem"
        case supdo = "humidity"
    }
    
    let temp: Double
    let humidity: Double?
}

extension Weather {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = (try? container.decode(Double.self, forKey: .ondo)) ?? 0.1111111
        humidity = try container.decode(Double.self, forKey: .supdo)
    }
}
