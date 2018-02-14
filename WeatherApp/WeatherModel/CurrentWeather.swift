

import Foundation
import UIKit
import SpriteKit




struct CurrentWeather {
    let temperature : Double
    let apparentTemperature : Double
    let humidity: Double
    let pressure : Double
    let icon : UIImage
    let summary : String
    let windSpeed : Double
}
extension CurrentWeather {
    var pressureString: String {
        return "pressure: \(Int(pressure * 0.750062)) mm"
    }
    var humidityString: String {
        return "humidity: \(Int(humidity * 100)) %"
    }
    var temperatureString: String {
        return "the temperature:\(Int(5 / 9 * (temperature - 32)))˚C"
    }
    var appearentTemperatureString: String {
        return "feels like: \(Int(5 / 9 * (apparentTemperature - 32)))˚C"
    }
  
    var summaryString: String {
        return "summary: \(String(summary)) "
    }
    var windSpeedString: String {
        return "wind speed: \(Double(windSpeed))meter/sec."
    }
 
}

extension CurrentWeather : JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
            let apparentTemperature = JSON ["apparentTemperature"] as? Double ,
            let humidity = JSON["humidity"] as? Double ,
            let pressure = JSON["pressure"] as? Double ,
            let summaryy =  JSON["summary"] as? String,
            let windSpeed =  JSON["windSpeed"] as? Double,
            let iconString = JSON["icon"] as? String else {
          
                return nil
        }
        
        let icon = WeatherIconManager(rawValue: iconString).image
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.humidity = humidity
        self.pressure = pressure
        self.icon = icon
        self.summary = summaryy
        self.windSpeed = windSpeed
    }
}




