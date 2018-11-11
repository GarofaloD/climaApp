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
    
    //Current location Web request
    func getCurrentLocation(latiude: String, longitude: String, appID : String, completion: @escaping CompletionHandler) {
        
        let requestCurrentLocation = "\(CURRENT_LOCATION)lat=\(latiude)&lon=\(longitude)&appid=\(appID)"
        
        Alamofire.request(requestCurrentLocation, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            if response.result.error == nil {
                let weatherJSON : JSON = JSON(response.result.value as Any)
                print(weatherJSON)
            
            } else {
                completion(false)
                print("Big error")
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    
    
    
}
