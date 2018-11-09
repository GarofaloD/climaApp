//
//  CitySelectionViewController.swift
//  climaApp
//
//  Created by Daniel Garofalo on 11/9/18.
//  Copyright © 2018 Daniel Garofalo. All rights reserved.
//

import UIKit

class CitySelectionViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var cityInput: UITextField!
    
    
    
    //MARK:- Properties
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
    
    
    
    @IBAction func getWeatherWhenPressed(_ sender: UIButton) {
    }
    
    
    
    
    @IBAction func returnToWeatherWhenPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    

}
