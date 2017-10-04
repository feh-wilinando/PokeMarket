//
//  Pokemon.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit
import ObjectMapper
class Card:  Mappable {
    
    var name:String!
    var price:Double = 19.9
    var imageURL: String!
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        imageURL <- map["imageUrl"]
    }
    
    
}
