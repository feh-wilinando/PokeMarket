
import Foundation

class ShoppingCart {
    
    private var items = Array<Card>()
    
    static let shared = ShoppingCart()
    
    private init(){}
    
    
    func total() -> Double {
        return items.map{$0.price}.reduce(0,+)
    }
    
    func size() -> Int {
        return items.count
    }
    
    func list() -> [Card] {
        return items
    }
    
    
    func find(by id:Int) -> Card {
        return items[id]
    }
    
    func add(_ item:Card) {
        items.append(item)
    }
    
    func remove(by id:Int){
        items.remove(at:id)
    }
    
    func clear() {
        items = Array()
    }
}
