//
//  APIWeatherManager.swift
//  WeatherApp
//
//  Created by Евгений Ковалевский on 15.01.2018.
//  Copyright © 2018 Евгений Ковалевский. All rights reserved.
//

import Foundation
struct Coordinates {
    var latitude : Double
    var longitude : Double
}

enum ForecastType : FinalURLPoint{
    case Current (apiKey : String , coordinates : Coordinates)
    var baseURL: URL {
        return URL(string: "https://api.forecast.io")!
    }
    var path: String {
        switch self  {
        case .Current(let apiKey , let coordinates ):
            return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
        }
    }
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
}

// в этом классе мы непосредственно тянем данные в проект
final class APIWeatherManager: APImanager {
    
    let sessionConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    let apiKey: String
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    func fetchCurrentWeatherWith(coordinates : Coordinates  , completionHandler : @escaping (APIresult<CurrentWeather>)-> Void) {
        let request = ForecastType.Current(apiKey: self.apiKey, coordinates: coordinates).request
        fetch(request: request, parse: { (json) -> CurrentWeather? in
            if let dictionary = json["currently"] as? [String : AnyObject] {
                return CurrentWeather(JSON: dictionary)
            } else {
                return nil
            }
        }, completionHandler: completionHandler)
    }
}







