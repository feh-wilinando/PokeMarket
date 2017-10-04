//
//  ShoppingCartViewController.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingCartViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let shoppingCart = ShoppingCart.shared
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTotal()
        
        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func reset(_ sender: Any) {
        
        shoppingCart.clear()
        
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Rx
    
    fileprivate func setupTableView(){
        
        
        //MARK: - Setup Delete
        tableView.rx.modelDeleted(Card.self).subscribe(onNext: { (card) in
            guard let row = self.shoppingCart.id(of: card) else {return}
            
            self.shoppingCart.remove(by: row)
            
        }).disposed(by: disposeBag)
        
        
        //MARK: - Setup DataSource
        shoppingCart
            .list()
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cartCell", cellType: UITableViewCell.self)){
                row, card, cell in
                
                cell.textLabel?.text = card.name
                cell.detailTextLabel?.text = "U$ \(card.price)"
                
        }.disposed(by: disposeBag)
        
    }
    
    fileprivate func setupTotal(){
        shoppingCart.list().asObservable().subscribe(onNext: {cards in
            self.totalLabel.text = "U$ \(self.shoppingCart.total())"
        }).disposed(by: disposeBag)
    }
    

}
