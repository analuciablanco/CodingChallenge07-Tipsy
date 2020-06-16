//
//  CalculatorController.swift
//  Tipsy
//
//  Created by Ana Lucia Blanco on 16/06/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipValue = 0.0
    var splitNumber = 0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        sender.isSelected = true
        
        switch sender.titleLabel {
        case zeroPctButton.titleLabel:
            tipValue = 0.0
        case tenPctButton.titleLabel:
            tipValue = 0.1
        case twentyPctButton.titleLabel:
            tipValue = 0.2
        default:
            print("Error")
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumber = Int(sender.value)
        splitNumberLabel.text = String(splitNumber)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultController
            
            destinationVC.result = calculateTotal()
            destinationVC.tip = Int(tipValue * 100)
            destinationVC.split = splitNumber
        }
    }
    
    func calculateTotal() -> String {
        let totalBill = Double(billTextField.text!) ?? 0.0
        
        let totalToPay = totalBill + (totalBill * tipValue)
        
        let totalToPayPerPerson = totalToPay/Double(splitNumber)
        
        return String(format: "%.2f", totalToPayPerPerson)
    }

}
