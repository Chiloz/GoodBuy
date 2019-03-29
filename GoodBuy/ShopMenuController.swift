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
    
<<<<<<< HEAD
    var souvenirs = [Souvenir]()
    var stringJSON = "-RTF.json"

    
    
    // Deze gegevens krijgen we van andere pagina's
    let countryCode = "RUB"
    var hoeveelheidGeld: Double = 5000
    let conversionRate: Double = 1/118
=======
    let souvenirNames = ["Serbian Mug", "Burek", "Balkan doll", "Postcard", "Serbian flag", "Serbian badge", "Serbian Mug", "Burek", "Balkan doll", "Postcard", "Serbian flag", "Serbian badge"]
    
    let souvenirImages: [UIImage] = [
        
        UIImage(named: "serbianmug")!,
        UIImage(named: "burek")!,
        UIImage(named: "balkandoll")!,
        UIImage(named: "postcard")!,
        UIImage(named: "serbianflag")!,
        UIImage(named: "serbianeagle")!,
        UIImage(named: "serbianmug")!,
        UIImage(named: "burek")!,
        UIImage(named: "balkandoll")!,
        UIImage(named: "postcard")!,
        UIImage(named: "serbianflag")!,
        UIImage(named: "serbianeagle")!
        
    ]
    
    let souvenirPrices = [690, 450, 1900, 70, 920, 450, 690, 450, 1900, 70, 920, 450]
>>>>>>> f3ea22410b490f52b0c4d08c472c8e8a6eabc4b5
    
    var selectedSouvenirs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
<<<<<<< HEAD
        
        let url = "https://www.noelherwig.com/"
        
        switch tabBarController!.selectedIndex {
        case 0:
            stringJSON = "-OMW.json"
            print(tabBarController?.selectedIndex)
        case 1:
            stringJSON = "-HTS.json"
            print(tabBarController?.selectedIndex)
        case 2:
            stringJSON = "-RTF.json"
            print(tabBarController?.selectedIndex)
        default:
            stringJSON = "-RTF.json"
            print(tabBarController?.selectedIndex)
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
=======
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return souvenirNames.count
>>>>>>> f3ea22410b490f52b0c4d08c472c8e8a6eabc4b5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
<<<<<<< HEAD
        cell.labelSouvenirName.text = self.souvenirs[indexPath.row].name
        
        let imageURL = URL(string: self.souvenirs[indexPath.row].imageURL!)
        let imageData = try! Data(contentsOf: imageURL!)
        cell.imageViewSouvenir.image = UIImage(data: imageData)
            
        
        
        cell.labelSouvenirPrice.text = String(format: "%.2f",self.souvenirs[indexPath.row].price!)
=======
        cell.labelSouvenirName.text = souvenirNames[indexPath.item]
        cell.imageViewSouvenir.image = souvenirImages[indexPath.item]
        cell.labelSouvenirPrice.text = String(souvenirPrices[indexPath.item])
>>>>>>> f3ea22410b490f52b0c4d08c472c8e8a6eabc4b5
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedSouvenirs.contains(indexPath.item) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.backgroundColor = UIColorFromHex(rgbValue: 0xD35451).cgColor
            selectedSouvenirs = selectedSouvenirs.filter(){$0 != indexPath.item}
            
<<<<<<< HEAD
            hoeveelheidGeld += self.souvenirs[indexPath.row].price!
            labelForeignAmount.text = String(format: "%.2f", hoeveelheidGeld)
            labelHomeAmount.text = String(format: "%.2f", conversionRate * hoeveelheidGeld)
            if (hoeveelheidGeld > 0) {
                labelForeignAmount.textColor = UIColor.white
            }

=======
//            teBesteden += souvenirPrices[indexPath.item]
//            labelTeBesteden.text = String(teBesteden)
>>>>>>> f3ea22410b490f52b0c4d08c472c8e8a6eabc4b5
        }
        else {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.layer.backgroundColor = UIColorFromHex(rgbValue: 0x70C4D3).cgColor
            selectedSouvenirs.append(indexPath.item)
            
<<<<<<< HEAD
            hoeveelheidGeld -= self.souvenirs[indexPath.row].price!
            labelForeignAmount.text = String(format: "%.2f", hoeveelheidGeld)
            labelHomeAmount.text = String(format: "%.2f", conversionRate * hoeveelheidGeld)
            if (hoeveelheidGeld < 0) {
                labelForeignAmount.textColor = UIColor.red
            }

        }
=======
//            teBesteden -= souvenirPrices[indexPath.item]
//            labelTeBesteden.text = String(teBesteden)
        }
        //        let cell = collectionView.cellForItem(at: indexPath)
        //        cell?.layer.backgroundColor = UIColorFromHex(rgbValue: 0x70C4D3).cgColor
        
>>>>>>> f3ea22410b490f52b0c4d08c472c8e8a6eabc4b5
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
