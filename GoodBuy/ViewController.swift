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
    
    
    var countryCode: String = ""
    var countryName: String = ""
    
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
                        self.countryCode = place.isoCountryCode!;
                        self.countryName = place.country!
                        self.button.isEnabled = true
                        self.button.backgroundColor = self.UIColorFromHex(rgbValue: 0xD35451)
                        //print(self.countryCode)
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
        let alertController = UIAlertController(title: "Location is disabled", message: "Location is needed for the services", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
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
        self.navigationController!.isNavigationBarHidden = true;
        manager.startUpdatingLocation()
        button.isEnabled = false
        button.backgroundColor = UIColorFromHex(rgbValue: 0xE4E4E4)
        button.clipsToBounds = true;
       
    }
    
    @IBAction func buttonContinue(_ sender: Any) {
//        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyConverterController") as? CurrencyConverterController {

//            self.ViewController!.pushViewController(VC, animated: true)
//        }
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyConverterController") as! CurrencyConverterController
        let navigationController = UINavigationController(rootViewController: VC)
        VC.countryName = countryName
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

   
    
}
