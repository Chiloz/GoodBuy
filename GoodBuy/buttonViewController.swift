//
//  buttonViewController.swift
//  GoodBuy
//
//  Created by Fontys on 04/04/2019.
//  Copyright © 2019 Woensel. All rights reserved.
//

import UIKit

class buttonViewController: UIViewController {

    @IBAction func buttonPressed0(_ sender: Any) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "ShopMenuController") as? ShopMenuController {
            VC.selectedScreen = 0
            self.navigationController!.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func buttonPressed1(_ sender: Any) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "ShopMenuController") as? ShopMenuController {
            VC.selectedScreen = 1
            self.navigationController!.pushViewController(VC, animated: true)
        }
    }
    
    @IBAction func buttonPressed2(_ sender: Any) {
        if let VC = self.storyboard?.instantiateViewController(withIdentifier: "ShopMenuController") as? ShopMenuController {
            VC.selectedScreen = 2
            self.navigationController!.pushViewController(VC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
