//
//  ViewController.swift
//  Currency Converter
//
//  Created by Bülent Siyah on 21.02.2018.
//  Copyright © 2018 Bülent Siyah. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        getCurrency(currency:searchBar.text!)
        //searchBar.text = ""
    }
    
    func getCurrency(currency: String){
        let url = URL(string: "https://api.fixer.io/latest?base=\(currency)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                
                if data != nil {
                    do{
                        let jSONResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                        
                        DispatchQueue.main.async {
                            print(jSONResult)
                            print(jSONResult["base"])
                            let rates = jSONResult["rates"] as! [String: AnyObject]
                            
                            let usd = String(describing: rates["USD"]!)
                            self.usdLabel.text = "USD:\(usd)"
                            
                            let cad = String(describing: rates["CAD"]!)
                            self.cadLabel.text = "CAD:\(cad)"
                            
                            let chf = String(describing: rates["CHF"]!)
                            self.chfLabel.text = "CHF:\(chf)"
                            
                        }
                        
                    }catch{
                        
                    }
                }
            }
        }
        task.resume()
    }

}

