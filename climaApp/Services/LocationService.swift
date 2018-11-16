//
//  LocationService.swift
//  climaApp
//
//  Created by Daniel Garofalo on 11/10/18.
//  Copyright © 2018 Daniel Garofalo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LocationService {
    
    //Singleston for instance call
    static let instance = LocationService()
    
    //Model Object
    let weatherData = WeatherData()
    
    //Other Properties
    var jsonDataFromLocation : JSON = ""
    
    
    //Current location Web request
    func getCurrentLocation(latiude: String, longitude: String, appID : String, completion: @escaping CompletionHandler) {
        
        let requestCurrentLocation = "\(CURRENT_LOCATION)lat=\(latiude)&lon=\(longitude)&appid=\(appID)"
        
        Alamofire.request(requestCurrentLocation, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error == nil {
                
                let weatherJSON : JSON = JSON(response.result.value as Any)
                self.jsonDataFromLocation = weatherJSON
                //print(weatherJSON)
                //self.updateWeatherData(json: self.jsonDataFromLocation)
                
                if let temperatureFromJSON = weatherJSON["main"]["temp"].double {
                    //temperature comes oin Kelvin. This is the formula to convert to Fahrenheit
                    let temp = Int((temperatureFromJSON - 273.15) * (9/5) + 32)
                    let city = weatherJSON["name"].stringValue
                    let condition = weatherJSON["weather"][0]["id"].intValue
                    let weatherIconName = IconService.instance.updateWeatherIcon(condition: condition)
                
                    //self.weatherData.setWeatherData(temperature: temp, condition: condition, city: city, weatherIconName: weatherIconName)
                    WeatherData.instance.setWeatherData(temperature: temp, condition: condition, city: city, weatherIconName: weatherIconName)
                }
                
                print(self.weatherData.city)
                print(self.weatherData.temperature)
                print(self.weatherData.condition)
                print(self.weatherData.weatherIconName)
                
                completion(true)
            } else {
                completion(false)
                print("Weather unavailable")
                debugPrint(response.result.error as Any)
            }
        }
    }
    
//    //JSON Parsing
//    func updateWeatherData(json: JSON){
//
//        let tempResult = json["main"]["temp"].stringValue
//        print(tempResult)
//        //print(json)
//    }
    
    
    
    
}
