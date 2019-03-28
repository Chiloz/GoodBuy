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
    
    let manager = CLLocationManager()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[0]
        
        //let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        //let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        //let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        //map.setRegion(region, animated: true)
        
        print(location.altitude)
        print(location.speed)
        
        //self.map.showsUserLocation = true
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil
            {
                print("THERE WAS AN ERROR")
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
                        self.label.text = "NO SIGNAL"
                    }
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        button.layer.cornerRadius = 10;
        button.clipsToBounds = true;
       
       
    }
    
   
    
   

   
    
}
