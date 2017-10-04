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
import RxSwift
import RxCocoa

class CardsTableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let shoppingCart = ShoppingCart.shared
    let cardServices = CardServices.shared
    
    let disposeBag = DisposeBag()
    var pokeCards = Variable(Array<Card>())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonCount()
        setupTableView()
        
        tableView.delegate = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(navigationDetail(sender:)))
        
        tableView.addGestureRecognizer(longPress)
        
        cardServices.fechCards { (cards) in
            self.pokeCards.value = cards
        }
        
    }

    
    //MARK: - Rx
    
    fileprivate func setupButtonCount(){
        
        shoppingCart.list().asObservable()
            .subscribe(onNext: { (cards) in
                self.navigationItem.rightBarButtonItem?.title = "Shopping Cart \(cards.count)"
        }).disposed(by: disposeBag)
    }
    
    
    
    fileprivate func setupTableView(){
        pokeCards
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "cardCell", cellType: CardCell.self)){
            row, card, cell in
            
            cell.inflate(with: card)
        }.disposed(by: disposeBag)
    }
    
    
    func navigationDetail(sender gesture: UIGestureRecognizer){
        
        
        if gesture.state == .began {
            
            let point = gesture.location(in: tableView)
            
            guard let indexPath = tableView.indexPathForRow(at: point) else {return}
            guard let detailView = storyboard?.instantiateViewController(withIdentifier: "detailView") as? DetailViewController else {return}
            
            
            detailView.card.value = pokeCards.value[indexPath.row]
            
            navigationController?.pushViewController(detailView, animated: true)
            
        }
        
    }

}


extension CardsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = pokeCards.value[indexPath.row]
        
        shoppingCart.add(card)
        
    }
    
}
