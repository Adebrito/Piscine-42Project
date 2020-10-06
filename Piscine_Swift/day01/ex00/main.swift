print("---------------------\nFOREACH VALUE\n----------------")
Color.allColors.forEach {
    print("\($0) hashValue:" + String($0.hashValue) + " => rawValue: " + $0.rawValue)
}
print("---------------------\nFOREACH VALUE\n----------------")
Value.allValues.forEach {
    print("\($0) hashValue:" + String($0.hashValue) + " => rawValue: " + String($0.rawValue))
}

print("\n PRINT TEST Color\n")
print("\(Color.DIAMOND) hashValue:" + String(Color.DIAMOND.hashValue) + " => rawValue: " + Color.DIAMOND.rawValue + " value in allValue: \(Color.allColors[Color.DIAMOND.hashValue].rawValue)")
print("\n PRINT TEST VALUE\n")
print("\(Value.JACK) hashValue:" + String(Value.JACK.hashValue) + " => rawValue: " + String(Value.JACK.rawValue) + " value in allValue : \(String(Value.allValues[Value.JACK.hashValue].rawValue))")