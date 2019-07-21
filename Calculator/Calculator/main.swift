//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

var operations: ([String: (Double, Double) -> Double]) = ["+": { $0 + $1 },
                                                          "-": { $0 - $1 },
                                                          "*": { $0 * $1 },
                                                          "/": { $0 / $1 }]

//gets input character from user.
func getInput() -> String? {
    return readLine(strippingNewline: true)!
}

func regular() {
    print("Enter you operation. e.g '2 + 2'")
    
    let operationString = getInput()!
    
    let operationArray: [String?] = operationString.components(separatedBy: " ")
    
    if operationArray.count == 3,
    let x: String = operationArray[0],
    let y: String = operationArray[2],
    let mathSymbol: String = operationArray[1],
    let mathOperation = operations[mathSymbol]{
        let result = mathOperation(Double(x)!, Double(y)!)
        
        print("\(x) \(mathSymbol) \(y) = \(result)")
    }else{
        print("Wrong operation!")
    }
}

func highOrder() {
    print("high order!")
}

func calculator() {
    print("Welcome")
    print("Enter type of calculation, 1 regular, 2 high order?")
    
    let typeOfCalculation = getInput()!
    
    switch typeOfCalculation {
    case "1":
        regular()
    case "2":
        highOrder()
    default:
        print("Wrong choice!")
    }
    
}

func main() {
    var wantsToCalculate = true //default value of var is assuming person wants to play.
    
    while wantsToCalculate{ //while wants to play is true, start game loop.
        calculator()
        
        print("Calculate again? y/n")
        
        let answer = getInput()! // gets input from user whether wants to play or not.
        if answer.lowercased() == "n" { //if answer is no, game doesn't restart.
            wantsToCalculate = false
            print("Ok. Bye bye!")
        }
    }
}

main()
