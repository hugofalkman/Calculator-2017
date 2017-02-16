//
//  ViewController.swift
//  CalculatorStanford
//
//  Created by H Hugo Falkman on 2017-02-15.
//  Copyright © 2017 H Hugo Falkman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var userIsTyping = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            let textInDisplay = display.text!
            display.text = textInDisplay + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOp(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }
        
        if let mathSymbol = sender.currentTitle {
            brain.performOp(mathSymbol)
        }
        
        if let result = brain.result {
            displayValue = result
        }
    }
}
