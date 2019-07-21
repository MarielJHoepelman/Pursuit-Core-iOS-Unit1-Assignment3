//
//  main.swift
//  Calculator
//
//  Created by Mariel Hoepelman on 07/20/2019.
//  Copyright © Mariel Hoepelman. All rights reserved.
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
    let mathSymbol: String = operationArray[1]{
        var mathOperation:(Double, Double) -> Double
        
        if mathSymbol == "?" {
            let randomOperation = operations.randomElement()! // returns ie: ["-": { $0 - $1 }]
            mathOperation = randomOperation.value
            
            let result = mathOperation(Double(x)!, Double(y)!) // { $0 - $1 } or { $0 + $1 } etc
            
            print("\(x) \(mathSymbol) \(y) = \(result)")
            
            print("What operation was perfomed?")
            let answer = getInput()!
            
            if answer == randomOperation.key {
                print("Correct!, the operation was \"\(randomOperation.key)\"")
            } else {
                print("Nope..the operation was \"\(randomOperation.key)\"")
            }
    
        } else {
            mathOperation = operations[mathSymbol]!
            
            let result = mathOperation(Double(x)!, Double(y)!)
            
            print("\(x) \(mathSymbol) \(y) = \(result)")
        }
        
    }else{
        print("Wrong operation!")
    }
}

func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {
    var newArr:[Int] = []
    
    for x in inputArray{
        if filter(x) {
            newArr.append(x)
        }
    }
    return newArr
}

func myMap(inputArray: [Int], map: (Int) -> Double) -> [Double] {
    var newArr:[Double] = []
    
    for x in inputArray{
        newArr.append(map(x))
    }
    return newArr
}

func myReduce(inputArray: [Int], initial: Double, reduce: (Double, Double) -> Double) -> Double {
    var result: Double = initial
    
    for x in inputArray{
        result = reduce(Double(result), Double(x))
    }
    return result
}

func highOrder() {
    print("Enter your operation. e.g filter 1,5,2,7,3,4 by < 4")
    
    let operationString = getInput()!
    
    let operationArray: [String?] = operationString.components(separatedBy: " ")

//    [Optional("filter"), Optional("1,5,2,7,3,4"), Optional("by"), Optional("<"), Optional("4")]
   
    if operationArray.count == 5,
    let highOrderOperation: String = operationArray[0],
    let highOrderValues: String = operationArray[1],
    let highOrderSymbol: String = operationArray[3],
    let highOrderInt: String = operationArray[4] {
        let highOrderValuesArray = highOrderValues.components(separatedBy: ",").map { Int($0)!}
        
        
        switch highOrderOperation {
        case "filter":
            if highOrderSymbol == ">" {
                print(myFilter(inputArray: highOrderValuesArray, filter: { $0 > Int(highOrderInt)!}))
            } else if highOrderSymbol == "<" {
                print(myFilter(inputArray: highOrderValuesArray, filter: { $0 < Int(highOrderInt)! }))
            }
            
        case "map":
            if highOrderSymbol == "*" {
                print(myMap(inputArray: highOrderValuesArray, map: { Double($0) * Double(highOrderInt)!}))
            } else if highOrderSymbol == "/" {
                print(myMap(inputArray: highOrderValuesArray, map: { Double($0) / Double(highOrderInt)! }))
            }
        case "reduce":
            if highOrderSymbol == "+" {
                print(myReduce(inputArray: highOrderValuesArray, initial: Double(highOrderInt)!, reduce: { Double($0) + Double($1) }))
            } else if highOrderSymbol == "*"{
                print(myReduce(inputArray: highOrderValuesArray, initial: Double(highOrderInt)!, reduce: { Double($0) / Double($1) }))
            }
        default:
            print("Wrong choice!")
        }

    }
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
    var wantsToCalculate = true //default value of var is assuming person wants to calculate.
    
    while wantsToCalculate{ //while wants to calculate is true, start the calculator.
        calculator()
        
        print("Calculate again? y/n")
        
        let answer = getInput()! // gets input from user whether wants to continue or not.
        if answer.lowercased() == "n" { //if answer is no, exit CLI.
            wantsToCalculate = false
            print("Ok. Bye bye!")
        }
    }
}

main()
