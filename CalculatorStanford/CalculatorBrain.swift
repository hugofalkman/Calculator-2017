//
//  CalculatorBrain.swift
//  CalculatorStanford
//
//  Created by H Hugo Falkman on 2017-02-15.
//  Copyright © 2017 H Hugo Falkman. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accum: Double?
    
    private enum Op {
        case constant(Double)
        case unaryOp((Double) -> Double)
        case binaryOp((Double,Double) -> Double)
        case equals
    }
    
    private var ops = [
        "π" : Op.constant(Double.pi),
        "e" : Op.constant(M_E),
        "√" : Op.unaryOp(sqrt),
        "cos" : Op.unaryOp(cos),
        "±" : Op.unaryOp({ -$0 }),
        "×" : Op.binaryOp({ $0 * $1 }),
        "÷" : Op.binaryOp({ $0 / $1 }),
        "−" : Op.binaryOp({ $0 - $1 }),
        "+" : Op.binaryOp({ $0 + $1 }),
        "=" : Op.equals
    ]
    
    mutating func performOp(_ symbol: String) {
        if let op = ops[symbol] {
            switch op {
            case .constant(let value):
                accum = value
            case .unaryOp(let function):
                if accum != nil {
                    accum = function(accum!)
                }
            case .binaryOp(let function):
                if accum != nil {
                    pendingBinaryOp = PendingBinaryOp(function: function, op1: accum!)
                    accum = nil
                }
            case .equals:
                performPendingBinaryOp()
            }
        }
    }
    
    private mutating func performPendingBinaryOp() {
        if pendingBinaryOp != nil && accum != nil {
            accum = pendingBinaryOp!.perform(with: accum!)
            pendingBinaryOp = nil
        }
    }
    
    private var pendingBinaryOp: PendingBinaryOp?
    
    private struct PendingBinaryOp {
        let function: (Double,Double) -> Double
        let op1: Double
        
        func perform(with op2: Double) -> Double {
            return function(op1, op2)
        }
    }
    
    mutating func setOperand (_ operand: Double) {
        accum = operand
    }
    
    var result: Double? {
        get {
            return accum
        }
    }
}
