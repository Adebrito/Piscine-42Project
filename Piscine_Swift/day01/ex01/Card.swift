import Foundation

class Card: NSObject {
    var color : Color
    var value : Value
    
    init(c: Color, v: Value) {
        self.color = c
        self.value = v
    }
    
    override var description: String {
        return "color: \(color), value: \(value) "
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let card = object as? Card  {
            return card.value == self.value && card.color == self.color
        }
        return false
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return rhs.value == lhs.value && rhs.color == lhs.color
    }
}