import Foundation
class Deck : NSObject {
    static let allSpades: [Card] = Value.allValues.map { Card(c: Color.SPADE, v: $0) }
    static let allDiamonds: [Card] = Value.allValues.map { Card(c: Color.DIAMOND, v: $0) }
    static let allHearts: [Card] = Value.allValues.map { Card(c: Color.HEART, v: $0) }
    static let allClubs: [Card] = Value.allValues.map { Card(c: Color.CLUB, v: $0) }
    static let allCards: [Card] = allSpades + allDiamonds + allHearts + allClubs
    var cards: [Card] = []
    var discards: [Card] = []
    var outs: [Card] = []
    
    init( isShuffle: Bool) {
        self.cards = Deck.allCards
        if isShuffle == true {
            cards.shuffle()
        }
    }
    
    override var description: String {
        if self.cards.count != 0 {
            return self.cards.reduce("") { $0 + $1.description + "\n" }
        }
        return String("cards is empty\n")
    }
    
    func draw() -> Card? {
        if self.cards.count != 0 {
            let card = self.cards.removeFirst()
            self.outs.append(card)
            return card
        }
        return nil
    }
    
    func fold(c: Card) {
        if let at = self.outs.index(where: { $0 == c }) {
            let card = self.outs.remove(at: at)
            self.discards.append(card)
        }
    }
}

extension Array {
    mutating func shuffle() {
        for _ in indices {
            sort { (_,_) in arc4random_uniform(20) < arc4random_uniform(20) }
        }
    }
}