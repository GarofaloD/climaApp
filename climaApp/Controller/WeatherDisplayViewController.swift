//
//  WeatherDisplayViewController.swift
//  climaApp
//
//  Created by Daniel Garofalo on 11/9/18.
//  Copyright © 2018 Daniel Garofalo. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherDisplayViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var citylabel: UILabel!
    
    //MARK:-  Properties / Instance Variables
    let locationManager = CLLocationManager()
    
    //MARK:- App Loading Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        //Specifying this VC as delegate for the location manager to tap the GPS
        locationManager.delegate = self
        //Accuracy needs to be specified
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        //And authorization needs to be requested
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    //Mark:- Location Methods
    
    //Weather at current location
    //If location manager succeds, we have to receive a notification when the location has been updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Tapping into the last element of the array of locations which will include the most accurate one
        let location = locations[locations.count - 1]
        //If the location is valid...
        if location.horizontalAccuracy > 0 {
            //stop updating the location
            locationManager.stopUpdatingLocation()
            //Stops the delegate so we can stop receiving messages. Useful because the console will nopt be filled up with duplicats
            locationManager.delegate = nil
            print("Latitude = \(location.coordinate.latitude), Longitude = \(location.coordinate.longitude)")
            
            //Separation of coordinates
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            //let params : [String: String] = ["lat": latitude, "lon": longitude]
            
            LocationService.instance.getCurrentLocation(latiude: latitude, longitude: longitude, appID: APPID) { (success) in
                if success {
                    self.weatherIcon.image = UIImage(named: WeatherData.instance.weatherIconName)
                    self.temperatureLabel.text = String(WeatherData.instance.temperature)
                    self.citylabel.text = WeatherData.instance.city
                    print("Temperature is: \(WeatherData.instance.temperature)")
                } else {
                    self.citylabel.text = "Connection issues..."
                }
            }
        }
    }
    
    
    //Weather at typed location
    func userEnteredANewCityName(city: String) {
        LocationService.instance.getLocationByName(q: city, appID: APPID) { (success) in
            if success {
                self.weatherIcon.image = UIImage(named: WeatherData.instance.weatherIconName)
                self.temperatureLabel.text = String(WeatherData.instance.temperature)
                self.citylabel.text = WeatherData.instance.city
                print("Temperature is: \(WeatherData.instance.temperature)")
            } else {
                 self.citylabel.text = "Connection issues..."
            }
        }
    }
    
    
    //If location manager failed
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        citylabel.text = "Location unavailable"
    }
    
    
    //Segue from  City selection VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //checking existance of segue name
        if segue.identifier == "goToCitySelection" {
            //Casting CitySelection as the destination
            let destinationVC = segue.destination as! CitySelectionViewController
            //With this, we make this vc to manage all the information passed by the other vc
            destinationVC.delegate = self
        }
    }

}
