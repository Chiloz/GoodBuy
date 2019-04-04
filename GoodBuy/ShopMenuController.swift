//
//  ShopMenuController.swift
//  GoodBuy
//
//  Created by Fontys on 22/03/2019.
//  Copyright © 2019 Woensel. All rights reserved.
//

import UIKit

// Samet doe niks in deze ding programmeren
// Deze is voor dat menu met die knoppen waar je souvenirs kunt kiezen

class ShopMenuController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var labelForeignCurrency: UILabel!
    @IBOutlet weak var labelForeignAmount: UILabel!
    
    @IBOutlet weak var labelHomeCurrency: UILabel!
    @IBOutlet weak var labelHomeAmount: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var souvenirs = [Souvenir]()
    var stringJSON = ""
    var selectedScreen = 0
    
    
    // Deze gegevens krijgen we van andere pagina's
    let countryCode = "RUB"
    var hoeveelheidGeld: Double = 5000
    let conversionRate: Double = 1/118
    
    var selectedSouvenirs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let url = "https://www.noelherwig.com/"
        
        print(selectedScreen)
        
        switch selectedScreen {
        case 0:
            stringJSON = "-RTF.json"
            self.title = "Ready to fly";
        case 1:
            stringJSON = "-OMW.json"
            self.title = "On my way";
        case 2:
            stringJSON = "-HTS.json"
            self.title = "Here to stay";
        default:
            stringJSON = "-RTF.json"
        }
        
        let urlOutput = URL(string: "\(url)\(countryCode)\(stringJSON)")

        labelForeignCurrency.text = countryCode
        labelForeignAmount.text = String(format: "%.2f", hoeveelheidGeld)
        labelHomeCurrency.text = "EUR"
        labelHomeAmount.text = String(format: "%.2f", conversionRate * hoeveelheidGeld)

        
        URLSession.shared.dataTask(with: urlOutput!) { (data, response, error) in
            
            if error != nil {
                print("\(error!.localizedDescription)")
            }
            
            guard let retrievedData = data else {
                return
            }
            
            do {
                let souvenirData = try JSONDecoder().decode([Souvenir].self, from: retrievedData)
                DispatchQueue.main.async {
                    self.souvenirs = souvenirData
                    self.collectionView.reloadData()
                }
            } catch let err {
                print("\(err)")
            }
            }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.souvenirs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.labelSouvenirName.text = self.souvenirs[indexPath.row].name
        
        let imageURL = URL(string: self.souvenirs[indexPath.row].imageURL!)
        let imageData = try! Data(contentsOf: imageURL!)
        cell.imageViewSouvenir.image = UIImage(data: imageData)
            
        
        
        cell.labelSouvenirPrice.text = String(format: "%.2f",self.souvenirs[indexPath.row].price!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedSouvenirs.contains(indexPath.item) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.backgroundColor = UIColorFromHex(rgbValue: 0xD35451).cgColor
            selectedSouvenirs = selectedSouvenirs.filter(){$0 != indexPath.item}
            
            hoeveelheidGeld += self.souvenirs[indexPath.row].price!
            labelForeignAmount.text = String(format: "%.2f", hoeveelheidGeld)
            labelHomeAmount.text = String(format: "%.2f", conversionRate * hoeveelheidGeld)
            if (hoeveelheidGeld > 0) {
                labelForeignAmount.textColor = UIColor.white
                labelHomeAmount.textColor = UIColor.white
            }

        }
        else {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.backgroundColor = UIColorFromHex(rgbValue: 0x70C4D3).cgColor
            selectedSouvenirs.append(indexPath.item)
            
            hoeveelheidGeld -= self.souvenirs[indexPath.row].price!
            labelForeignAmount.text = String(format: "%.2f", hoeveelheidGeld)
            labelHomeAmount.text = String(format: "%.2f", conversionRate * hoeveelheidGeld)
            if (hoeveelheidGeld < 0) {
                labelForeignAmount.textColor = UIColorFromHex(rgbValue: 0xEF6663)
                labelHomeAmount.textColor = UIColorFromHex(rgbValue: 0xEF6663)
            }

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //        let cell = collectionView.cellForItem(at: indexPath)
        //        cell?.layer.backgroundColor = UIColorFromHex(rgbValue: 0xD35451).cgColor
    }
    
    // Kleuren uit hexadecimalen
    // Voorbeeld voor #70C4D3: UIColorFromHex(rgbValue: 0x70C4D3).cgColor
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }

}
