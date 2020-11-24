//
//  CartAddViewController.swift
//  shoppingCartApp_HehnC
//
//  Created by Tiger Coder on 11/23/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class CartAddViewController: UIViewController {

    @IBOutlet weak var addLabel: UILabel!
    
    @IBOutlet weak var textOne: UITextField!
    @IBOutlet weak var textTwo: UITextField!
    
    var shopList = [String]()
    var detailList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLabel.textColor = UIColor.white
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        
        textOne.resignFirstResponder()
        textTwo.resignFirstResponder()
        
        let alertControl = UIAlertController(title: "HEY YOU!", message: "You left a prompt blank!", preferredStyle: .alert)
                   
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertControl.addAction(okAction)
        
        if textOne.text == "" {
             present(alertControl, animated: true, completion: nil)
            return
        }
        if textTwo.text == "" {
            present(alertControl, animated: true, completion: nil)
            return
        }
        
        for item in shopList {
            if item == textOne.text {
                let alertControlTwo = UIAlertController(title: "HEY YOU!", message: "You already have that item!", preferredStyle: .alert)
                alertControlTwo.addAction(okAction)
                
                present(alertControlTwo, animated: true, completion: nil)
                return
            }
        }
        
        shopList.append(textOne.text!)
        detailList.append(textTwo.text!)
        
        addLabel.textColor = UIColor.green
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.performSegue(withIdentifier: "unwindCart", sender: self)
        }
        
        
    }
    
}
