//
//  buttonViewController.swift
//  GoodBuy
//
//  Created by Fontys on 04/04/2019.
//  Copyright © 2019 Woensel. All rights reserved.
//

import UIKit

class buttonViewController: UIViewController {

    var conversion: Double = 0
    var currency: String = ""
    var countryName: String = ""
    var moneyAmount: Double = 0
    
    @IBAction func buttonPressed0(_ sender: Any) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "ShopMenuController") as? ShopMenuController {
            VC.selectedScreen = 0
            VC.conversion = conversion
            VC.currency = currency
            VC.countryName = countryName
            VC.moneyAmount = moneyAmount
            self.navigationController!.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func buttonPressed1(_ sender: Any) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "ShopMenuController") as? ShopMenuController {
            VC.selectedScreen = 1
            VC.conversion = conversion
            VC.currency = currency
            VC.countryName = countryName
            VC.moneyAmount = moneyAmount
            self.navigationController!.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func buttonPressed2(_ sender: Any) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "ShopMenuController") as? ShopMenuController {
            VC.selectedScreen = 2
            VC.conversion = conversion
            VC.currency = currency
            VC.countryName = countryName
            VC.moneyAmount = moneyAmount
            self.navigationController!.pushViewController(VC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.isNavigationBarHidden = true;

        // Do any additional setup after loading the view.
    }
}
