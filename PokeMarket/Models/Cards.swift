//
//  Cards.swift
//  PokeMarket
//
//  Created by Nando on 03/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import Foundation

import ObjectMapper
class Cards: Mappable {
    
    var value:[Card]!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        value <- map["cards"]
    }
}
