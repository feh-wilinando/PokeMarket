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

    let shoppingCart = ShoppingCart.shared
    var pokeCards:Array<Card> = Array<Card>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(navigationDetail(sender:)))
        
        tableView.addGestureRecognizer(longPress)
        
        
        Alamofire.request("https://api.pokemontcg.io/v1/cards")
            .responseObject(completionHandler: { (response: DataResponse<Cards>) in
                
                if let cards = response.result.value {
                    self.pokeCards = cards.value
                }
                
                self.tableView.reloadData()
            })

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateButtonTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        cell.cardName.text = card.name
        cell.cardPrice.text = "U$ \(card.price)"
        cell.cardImage.af_setImage(withURL: URL(string: card.imageURL)!)
        
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
    
    
    func updateButtonTitle(){
        navigationItem.rightBarButtonItem?.title = " Shopping Cart \(shoppingCart.size())"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
