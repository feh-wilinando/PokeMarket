//
//  ShoppingCartViewController.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let shoppingCart = ShoppingCart.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        updateTotal()            
    }

    @IBAction func reset(_ sender: Any) {
        
        shoppingCart.clear()
        
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func updateTotal() {
        totalLabel.text = "U$ \(shoppingCart.total())"
    }

}


extension ShoppingCartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.size()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        
        let card = shoppingCart.find(by: indexPath.row)
        
        cell.textLabel?.text = card.name
        cell.detailTextLabel?.text = "U$ \(card.price)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingCart.remove(by: indexPath.row)
            updateTotal()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
