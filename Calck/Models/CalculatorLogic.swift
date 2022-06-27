//
//  CalculatorLogic.swift
//  Calck
//
//  Created by Konstantin on 27.06.2022.
//

import Foundation

struct CalculatorLogic {
    
    private var number: Double?
    
    private var intermediateCalculation: (num1: Double, calcMethod: Constants)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    mutating func calculateOperation(operation: Constants) -> Double? {
        
        guard let number = number else {
            return nil
        }
     
        switch operation {
        case .plusMinus: return number * -1
        case .ac: return 0
        case .percent: return number * 0.001
        case .equal:
            return performTwoNumCalculation(num2: number)
        default:
            print(operation)
            intermediateCalculation = (num1: number, calcMethod: operation)
        
        }
        return nil
    }
    
    private func performTwoNumCalculation(num2: Double) -> Double? {
        
        guard let num1 = intermediateCalculation?.num1,
              let operation = intermediateCalculation?.calcMethod else { return 0 }
        
        switch operation {
        case .plus: return num1 + num2
        case .minus: return num1 - num2
        case .del: return num1 / num2
        case .myltiply: return num1 * num2
        default:
            fatalError("The operation passed in does not mathch any of the cases.")
        }
        
    }
    
}
