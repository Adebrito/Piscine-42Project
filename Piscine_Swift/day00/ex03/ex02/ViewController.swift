//
//  ViewController.swift
//  ex02
//
//  Created by Sebastien ALIBERT on 3/25/19.
//  Copyright © 2019 Sebastien ALIBERT. All rights reserved.
//

import UIKit

let ERROR_OVERFLOW = "overflow"

enum Operator: Int {
    case DIV = 11
    case MUL = 12
    case SUB = 13
    case ADD = 14
    case EQ = 15
}

enum MyError: Error {
    case createError(String)
}

class ViewController: UIViewController {

    @IBOutlet weak var currentCal: UILabel!
    @IBOutlet weak var firstTerm: UILabel!
    
    var isError: Bool! = false
    var lastInputIsOp: Bool! = true
    var usedOperator: Operator? = nil
    
    func clearFunc() {
        currentCal.text = ""
        firstTerm.text = ""
        isError = false
        lastInputIsOp = true
        usedOperator = nil
    }
    
    @IBAction func Clear(_ sender: Any) {
       clearFunc()
    }
    
    func cal (number1: String!, number2: String!, op : Operator!) throws -> String {
        switch(op) {
            case .DIV:
                if (Double(number2)?.isZero != true) {
                    return String(Double(number1)! / Double(number2)!)
                }
                throw MyError.createError("forbidden division 0")
            case .MUL:
                let result = Double(number1)! * Double(number2)!
                if result.isFinite == true {
                    return String(result)
                }
                throw MyError.createError(ERROR_OVERFLOW)
            case .SUB:
                let result = Double(number1)! - Double(number2)!
                if result.isFinite == true {
                    return String(result)
                }
                throw MyError.createError(ERROR_OVERFLOW)
            case .ADD:
                let result = Double(number1)! + Double(number2)!
                if result.isFinite == true {
                    return String(result)
                }
                throw MyError.createError(ERROR_OVERFLOW)
            default:
                throw MyError.createError("invalid operator")
        }
    }
    
    func selectOperator(op : Operator) -> Character {
        switch(op) {
        case .DIV:
            return "/"
        case .MUL:
            return "*"
        case .SUB:
            return "-"
        case .ADD:
            return "+"
        case .EQ:
            return "="
        }
    }
    @IBAction func ActionOperator(_ sender: UIButton) {
        if isError == true {
            clearFunc()
        }
        var op: Character? = nil
        let currentOp: Operator = Operator(rawValue: sender.tag)!

        if (lastInputIsOp == false && (currentOp == Operator.EQ || usedOperator != nil )) {
            if (usedOperator != nil && firstTerm.text! != "" && currentCal.text! != "") {
                do {
                    currentCal.text = try cal(number1: firstTerm.text! , number2: currentCal.text ,op: usedOperator)
                    firstTerm.text = ""
                } catch MyError.createError(let error) {
                    currentCal.text = error
                    firstTerm.text = ""
                    isError = true
                    print(error)
                } catch {
                }
            }
        }
        if (currentOp != Operator.EQ){
            if lastInputIsOp == true {
                currentCal.text = String(currentCal.text!.dropLast())
            } else {
                firstTerm.text = currentCal.text
                currentCal.text = ""
            }
            lastInputIsOp = true
            op = selectOperator(op: currentOp)
            print("operator = " + String(op!))
            currentCal.text = currentCal.text! + String(op!)
        }
        usedOperator = currentOp
    }
    
    @IBAction func Negative(_ sender: Any) {
        if var neg: Double = Double(currentCal.text!) {
            neg = neg * -1
            print(currentCal.text! + " * -1 = " + String(neg))
            currentCal.text = String(neg)
        } else {
            print("Empty neg")
        }
    }
    
    @IBAction func ActionPutNumber(_ sender: UIButton) {
        if (lastInputIsOp == false && usedOperator == Operator.EQ) || isError == true {
            clearFunc()
        }
        if lastInputIsOp == true && currentCal.text! != "" {
            lastInputIsOp = false
            currentCal.text! = ""
        }
        lastInputIsOp = false
        let number = currentCal.text! == "" ? Double(0) : Double(currentCal.text!)!
        let nextText = String((number * 10) + Double(sender.tag % 10))
        print(currentCal.text! + " add " + String(number) + " : " + nextText)
        currentCal.text = nextText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

