//
//  DetailViewController.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit
import AlamofireImage
import RxSwift
import RxCocoa


class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var card:Variable<Card> = Variable(Card())
    let disposeBag = DisposeBag()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupOutlets()
        navigationItem.title = "Details"
        
    }
    
    
    //MARK: - Rx
    
    private func setupOutlets(){
        bind(that: card.asObservable().map{$0.name}, with: nameLabel.rx.text)
        bind(that: card.asObservable().map{"U$ \($0.price)"}, with: priceLabel.rx.text)
        
        card.asObservable().map{$0.imageURL}.asObservable().subscribe(onNext: { (imageURL) in
            guard let url = URL(string: imageURL!) else {return}
            
            self.imageView.af_setImage(withURL: url)
            
        }).disposed(by: disposeBag)
        
        
    }

    private func bind<T>(that source: Observable<T>, with target: Binder<T>){
        source.bind(to: target).disposed(by: disposeBag)
    }
    
}
