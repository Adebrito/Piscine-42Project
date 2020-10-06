let OptinalCard : Card? = nil
let card1 = Card(c: Color.DIAMOND, v: Value.ACE)
let card2 = Card(c: Color.HEART, v: Value.JACK)
let card3 = card1


print("--------- DESCRIPTION CARD --------------\n")
print("card1 description : \(card1.description)")
print("card2 description : \(card2.description)")
print("card3 description : \(card3.description)")
print("OptionalCard description : \(String.init(describing:OptinalCard))")
print("\n")

print("--------- DESCRIPTION CARD --------------\n")
print("card1.isEqual(card2) : " + String(card1.isEqual(card2)))
print("card1.isEqual(card3) : " + String(card1.isEqual(card3)))
print("card1.isEqual(42) : " + String(card1.isEqual(Int(42))))
print("card1.isEqual(OptinalCard) : " + String(card1.isEqual(OptinalCard)))
print("\n")

print("--------- == CARD --------------\n")
print("card1 == card2) : " + String(card1 == card2))
print("card1 == card3) : " + String(card1 == card3))
print("card2 == OptinalCard) : " + String(card2 == OptinalCard))
print("\n")
