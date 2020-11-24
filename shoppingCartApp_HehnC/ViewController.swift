//
//  ViewController.swift
//  shoppingCartApp_HehnC
//
//  Created by Tiger Coder on 11/18/20.
//  Copyright © 2020 clc.hehn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Variables, Runtime, etc.
    @IBOutlet weak var shopView: UITableView!
    
    var shopList = [String]()
    var detailList = [String]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shopView.delegate = self
        shopView.dataSource = self
        
        if let detail = defaults.object(forKey: "detailSave") {
            detailList = detail as! [String]
        }
        if let shop = defaults.object(forKey: "shopSave") {
            shopList = shop as! [String]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(true)
          shopView.reloadData()
      }
    
    @IBAction func unwind(sender: UIStoryboardSegue){
        if let svc = sender.source as? CartAddViewController {
            shopList = svc.shopList
            detailList = svc.detailList
        }
    }

    // TableView Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shopView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = shopList[indexPath.row]
        cell.detailTextLabel?.text = detailList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shopList.remove(at: indexPath.row)
            detailList.remove(at: indexPath.row)
            
            shopView.deleteRows(at: [indexPath], with: .fade)
        }
        shopView.reloadData()
    }
    
    // Actual Functionality
    @IBAction func addCartAction(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "addCart", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              
            if segue.identifier == "addCart" {
            let nvc = segue.destination as! CartAddViewController
                
            nvc.shopList = shopList
            nvc.detailList = detailList
              }
          }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        defaults.set(shopList, forKey: "shopSave")
        defaults.set(detailList, forKey: "detailSave")
    }
}

