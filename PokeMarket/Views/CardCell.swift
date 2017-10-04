//
//  PokemonCell.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func inflate(with card:Card) {
        cardName.text = card.name
        cardPrice.text = "U$ \(card.price)"
        cardImage.af_setImage(withURL: URL(string: card.imageURL)!)
    }

}
