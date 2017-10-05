//
//  CardsTableViewController.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import AlamofireImage

class CardsTableViewController: UITableViewController {
    let cardServices = CardServices.shared
    let shoppingCart = ShoppingCart.shared
    var pokeCards:Array<Card> = Array<Card>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(navigationDetail(sender:)))
        
        tableView.addGestureRecognizer(longPress)
        
        
        
        cardServices.fetchCards { (cards) in
            self.pokeCards = cards
            self.tableView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateButtonTitle()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokeCards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardCell else {
            return UITableViewCell()
        }
        
        
        let card = pokeCards[indexPath.row]
        
        cell.inflate(with: card)
        
        return cell
    }
    
    
    func navigationDetail(sender: UIGestureRecognizer){
        
        
        if sender.state == .began {
            
            let point = sender.location(in: tableView)
            
            guard let indexPath = tableView.indexPathForRow(at: point) else {return}
            guard let detailView = storyboard?.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else {return}
            
            
            detailView.card = pokeCards[indexPath.row]
            
            navigationController?.pushViewController(detailView, animated: true)
            
        }
        
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = pokeCards[indexPath.row]
        
        shoppingCart.add(card)
        
        updateButtonTitle()
        
    }
    
    fileprivate func updateButtonTitle(){
        navigationItem.rightBarButtonItem?.title = " Shopping Cart \(shoppingCart.size())"
    }
}
