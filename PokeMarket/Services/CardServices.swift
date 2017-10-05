//
//  CardServices.swift
//  PokeMarket
//
//  Created by Nando on 05/10/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CardServices {
    
    static let shared = CardServices()
    
    fileprivate init(){}
    
    func fetchCards(onCompletion completion: @escaping ([Card]) -> Void ) {
        
        Alamofire.request("https://api.pokemontcg.io/v1/cards")
            .responseObject(completionHandler: { (response: DataResponse<Cards>) in
                
                if let cards = response.result.value {
                    completion(cards.value)
                }
                
            })
    }
    
}
