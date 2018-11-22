//
//  CitySelectionViewController.swift
//  climaApp
//
//  Created by Daniel Garofalo on 11/9/18.
//  Copyright © 2018 Daniel Garofalo. All rights reserved.
//

import UIKit


//Protocol declaration to be able to type the city that will be passed to the WeatherDisplayVC
protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}


class CitySelectionViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var cityInput: UITextField!
    
    //MARK:- Properties
    //By convention, when you call the protocol it needs to have the "delegate" as name. Also, we need to cast it a an optional to avoif the return of a nil
    var delegate : ChangeCityDelegate?
    

    //MARK:- App Loading functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    //MARK:- Functions/Actions
    @IBAction func getWeatherWhenPressed(_ sender: UIButton) {
        
        //check if there is text in that field
        guard let cityName = cityInput.text else {return}
        //If the delegate is not empty, apply the city name
        delegate?.userEnteredANewCityName(city: cityName)
        //And dismiss this vc, taking us to the main vc
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func returnToWeatherWhenPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
