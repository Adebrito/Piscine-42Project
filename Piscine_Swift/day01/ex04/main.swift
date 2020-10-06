var deck = Deck(isShuffle: false)
print("------------ DECK NO SHUFLLE ------------")
print(deck.description)
print("\n")

print("------------ DECK SHUFLLE ------------")
deck = Deck(isShuffle: true)
print("\n")

var array: [Card] = []
var goinfre: [Card] = []

print("---DESCRIPTION DECK---")
print(deck.description)
print("\n")
for _ in 0..<5 {
    array.append(deck.draw()!)
    print("card \(array[array.count-1])")
    print("size outs :\(String(deck.outs.count))\n")
}

print("---DECK OUTS---")
print(deck.outs)
print("\n")

for el in array {
    deck.fold(c: el)
    print("size outs :\(String(deck.outs.count))")
    print("size discards :\(String(deck.discards.count))")
}

print("\n---------DECK DISCARDS---------")
print(deck.discards)
print("\n")

for _ in 0..<20 {
    if let card = deck.draw() {
        goinfre.append(card)
    }
}

for el in array {
    deck.fold(c: el)
    print("size outs :\(String(deck.outs.count))")
    print("size discards :\(String(deck.discards.count))")
}
print("\n")
print(deck.description)
print("--------PURGE 1000---------")
for _ in 0..<1000 {
    if let card = deck.draw() {
        goinfre.append(card)
    }
}
print(deck.description)

deck.outs = []
deck.fold(c: array[0])