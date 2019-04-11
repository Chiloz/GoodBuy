//
//  CurrencyConverterController.swift
//  GoodBuy
//
//  Created by Fontys on 04/04/2019.
//  Copyright © 2019 Woensel. All rights reserved.
//

import UIKit

class CurrencyConverterController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var labelHomeAmount: UILabel!
    @IBOutlet weak var labelHomeCurrency: UILabel!
    @IBOutlet weak var labelForeignCurrency: UILabel!
    @IBOutlet weak var labelForeignCountry: UILabel!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var viewHomeCurrency: UIView!
    
    var output: Double = 0;
    var input: String = ""

    
    var countryName: String = ""
    var currency: String = ""
    var conversion: Double = 0
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func textFieldChanged(_ sender: Any) {
        
        print(textField.text as Any)
        labelHomeAmount.text = textField.text
        input = textField.text!
        
        if textField.text == nil || textField.text == "" {
            buttonConfirm.backgroundColor = UIColorFromHex(rgbValue: 0xE4E4E4)
            viewHomeCurrency.backgroundColor = UIColorFromHex(rgbValue: 0xE4E4E4)
            
            labelHomeAmount.textColor = UIColorFromHex(rgbValue: 0x9DA3A3)
            labelHomeCurrency.textColor = UIColorFromHex(rgbValue: 0x9DA3A3)
            
            buttonConfirm.isEnabled = false
            
        }
        else {
            buttonConfirm.backgroundColor = UIColorFromHex(rgbValue: 0xD35451)
            viewHomeCurrency.backgroundColor = UIColorFromHex(rgbValue: 0x70C4D3)
            labelHomeAmount.textColor = UIColor.white
            labelHomeCurrency.textColor = UIColor.white
            
            buttonConfirm.isEnabled = true
            
            output = conversion * Double(input)!
            print(output)
            //            labelHomeAmount.text = String(round(100*output)/100)
            labelHomeAmount.text = String(format: "%.2f", output)
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("Confirmed!")
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ButtonViewController") as! buttonViewController
        let navigationController = UINavigationController(rootViewController: VC)
        VC.conversion = conversion
        VC.currency = currency
        VC.countryName = countryName
        VC.moneyAmount = Double(input)!
        self.present(navigationController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonConfirm.isEnabled = false
        
        if countryName == "Netherlands" || countryName == "United Kingdom" {
            labelForeignCountry.text = "Welcome to the \(countryName)!"
        }
        else {
            labelForeignCountry.text = "Welcome to \(countryName)!"
        }
        textField.becomeFirstResponder()
        self.navigationController!.isNavigationBarHidden = true;
        
        switch countryName {
        case "Russia":
            currency = "RUB"
            conversion = 0.01374
        case "United Kingdom":
            currency = "GBP"
            conversion = 1.17076
        case "Japan":
            currency = "JPY"
            conversion = 0.00799
        case "Australia":
            currency = "AUD"
            conversion = 0.63362
        case "Mexico":
            currency = "MXN"
            conversion = 0.04633
        case "Brazil":
            currency = "BRL"
            conversion = 0.22994
        default:
            currency = "EUR"
            conversion = 1
        }
        
        textField.delegate = self
        
        labelForeignCurrency.text = currency
    }
    
    // Kleuren uit hexadecimalen
    // Voorbeeld voor #70C4D3: UIColorFromHex(rgbValue: 0x70C4D3).cgColor
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 9
    }
}
