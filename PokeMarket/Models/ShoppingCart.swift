
import Foundation
import RxSwift

class ShoppingCart {
    
    private var items: Variable<Array<Card>> = Variable([])
    
    static let shared = ShoppingCart()
    
    private init(){}
    
    
    func total() -> Double {
        return items.value.map{$0.price}.reduce(0,+)
    }
    
    func size() -> Int {
        return items.value.count
    }
    
    func list() -> Variable<[Card]> {
        return items
    }
    
    
    func find(by id:Int) -> Card {
        return items.value[id]
    }
    
    func add(_ item:Card) {
        items.value.append(item)
    }
    
    func remove(by id:Int){
        items.value.remove(at:id)
    }
    
    func id(of card:Card) -> Int? {
        return items.value.index { $0.name == card.name }
    }
    
    func clear() {
        items.value = Array()
    }
}
