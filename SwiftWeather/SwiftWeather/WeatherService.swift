//
//  WeatherService.swift
//  SwiftWeather
//
//  Created by YangRong on 15/8/14.
//  Copyright © 2015年 arron. All rights reserved.
//

import Foundation
import CoreLocation
import Pitaya

public enum Status {
    case success
    case failure
}

public class Response {
    public var status: Status = .failure
    public var object: JSON? = nil
    public var error: NSError? = nil
}

public class WeatherService {
    public init(){
        
    }
    
    public func retrieveForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees, success:(response: Response)->(), failure: (response:Response)->()){
        let url = "http://api.openweathermap.org/data/2.5/forecast"
        let params = ["lat":latitude, "lon":longitude]
        
        Pitaya.request(.GET, url: url, params: params, errorCallback: { (error) -> Void in
            NSLog(error.localizedDescription)
            }) { (data, response) -> Void in
                let json = JSON(data: data!)
                var response = Response()
                response.status = .success
                response.object = json
                success(response: response)
        }
    }
    
    public func updateWeatherIcon(condition: Int, nightTime: Bool, index: Int, callback:(index: Int, name: String)->()) {
        // Thunderstorm
        if (condition < 300) {
            if nightTime {
                callback(index: index, name: "tstorm1_night")
            } else {
                callback(index: index, name: "tstorm1")
            }
        }
            // Drizzle
        else if (condition < 500) {
            callback(index: index, name: "light_rain")
            
        }
            // Rain / Freezing rain / Shower rain
        else if (condition < 600) {
            callback(index: index, name: "shower3")
        }
            // Snow
        else if (condition < 700) {
            callback(index: index, name: "snow4")
        }
            // Fog / Mist / Haze / etc.
        else if (condition < 771) {
            if nightTime {
                callback(index: index, name: "fog_night")
            } else {
                callback(index: index, name: "fog")
            }
        }
            // Tornado / Squalls
        else if (condition < 800) {
            callback(index: index, name: "tstorm3")
        }
            // Sky is clear
        else if (condition == 800) {
            if (nightTime){
                callback(index: index, name: "sunny_night")
            }
            else {
                callback(index: index, name: "sunny")
            }
        }
            // few / scattered / broken clouds
        else if (condition < 804) {
            if (nightTime){
                callback(index: index, name: "cloudy2_night")
            }
            else{
                callback(index: index, name: "cloudy2")
            }
        }
            // overcast clouds
        else if (condition == 804) {
            callback(index: index, name: "overcast")
        }
            // Extreme
        else if ((condition >= 900 && condition < 903) || (condition > 904 && condition < 1000)) {
            callback(index: index, name: "tstorm3")
        }
            // Cold
        else if (condition == 903) {
            callback(index: index, name: "snow5")
        }
            // Hot
        else if (condition == 904) {
            callback(index: index, name: "sunny")
        }
            // Weather condition is not available
        else {
            callback(index: index, name: "dunno")
        }
    }
    
    public func convertTemperature(country: String, temperature: Double)->Double{
        if (country == "US") {
            // Convert temperature to Fahrenheit if user is within the US
            return round(((temperature - 273.15) * 1.8) + 32)
        }
        else {
            // Otherwise, convert temperature to Celsius
            return round(temperature - 273.15)
        }
    }
    
    public func isNightTime(icon: String)->Bool {
        return icon.rangeOfString("n") != nil
    }
}