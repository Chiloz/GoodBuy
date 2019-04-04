//
//  ViewController.swift
//  GoodBuy
//
//  Created by Fontys on 15/03/2019.
//  Copyright © 2019 Woensel. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let manager = CLLocationManager()
    
    
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil
            {
                //print("THERE WAS AN ERROR")
            }
            else
            {
                if let place = placemark?[0]
                {
                    if let checker = place.locality
                    {
                        self.label.text = "\(place.locality!), \n \(place.country!) "
                    }
                    else
                    {
                        //self.label.text = "NO SIGNAL"
                    }
                }
            }
        } 
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location is disabled", message: "Location needed for the services", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open settings", style: .default){ (action)  in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
//        if authorizationStatus == .denied || authorizationStatus == .restricted {
//            print("location denied")
//
//        }
        manager.startUpdatingLocation()
        button.layer.cornerRadius = 10;
        button.clipsToBounds = true;
       
    }
    
   
    
   

   
    
}
