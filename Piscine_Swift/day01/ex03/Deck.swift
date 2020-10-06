import Foundation

class Deck : NSObject {
    static let allSpades: [Card] = Value.allValues.map { Card(c: Color.SPADE, v: $0) }
    static let allDiamonds: [Card] = Value.allValues.map { Card(c: Color.DIAMOND, v: $0) }
    static let allHearts: [Card] = Value.allValues.map { Card(c: Color.HEART, v: $0) }
    static let allClubs: [Card] = Value.allValues.map { Card(c: Color.CLUB, v: $0) }
    static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
}

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random_uniform(20) < arc4random_uniform(20) }
        }
    }
}