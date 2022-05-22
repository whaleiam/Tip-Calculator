//
//  ViewController.swift
//  ChungWilliamHW4
//
//  Created by William Chung on 3/18/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setDefaultValues()
        
        // UI components that you can interact with
        enterBill.accessibilityIdentifier = HW4AccessibilityIdentifiers.billTextField
        enterTaxPercent.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedTax
        inputIncludeTax.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxSwitch
        enterTipPercent.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipSlider
        enterNumPeople.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitStepper
        clearButton.accessibilityIdentifier = HW4AccessibilityIdentifiers.resetButton
        
        // all the dyamic labels that will change based on userinput
        tax.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxAmountLabel
        subTotal.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalAmountLabel
        tip.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipAmountLabel
        totalWithTip.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipAmountLabel
        totalPerPerson.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonAmountLabel
        tipPercentLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.sliderLabel
        peopleCountLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.splitLabel
        
        //static labels that dont change - title labels
        tipCalcLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipCalculaterLabel
        billLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.billLabel
        segLLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.segmentedLabel
        includeTaxSwitch.accessibilityIdentifier = HW4AccessibilityIdentifiers.includeTaxLabel
        taxLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.taxLabel
        subLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.subtotalLabel
        tipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.tipLabel
        totWithTipLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalWithTipLabel
        totPerPersonLabel.accessibilityIdentifier = HW4AccessibilityIdentifiers.totalPerPersonLabel
        viewControl.accessibilityIdentifier = HW4AccessibilityIdentifiers.view
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        enterBill.resignFirstResponder()
    }
    
    @IBOutlet weak var tipCalcLabel: UILabel!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var segLLabel: UILabel!
    @IBOutlet weak var includeTaxSwitch: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totWithTipLabel: UIView!
    @IBOutlet weak var totPerPersonLabel: UIView!
    @IBOutlet weak var viewControl: UIView!
    
    @IBOutlet weak var enterBill: UITextField! // Bill Amount
    @IBOutlet weak var enterTaxPercent: UISegmentedControl! // Tax Percentage
    @IBOutlet weak var inputIncludeTax: UISwitch! // Include Tax before Tip?
    @IBOutlet weak var enterTipPercent: UISlider! // Tip percentage
    @IBOutlet weak var enterNumPeople: UIStepper! // Counts people
    
    
    @IBOutlet weak var tipPercentLabel: UILabel! // Displays tip percentage value from slider
    @IBOutlet weak var peopleCountLabel: UILabel! // Displays the people count from stepper
    
    @IBOutlet weak var tax: UILabel! // Displays the amount of tax
    @IBOutlet weak var subTotal: UILabel! // Displays the subtotal
    @IBOutlet weak var tip: UILabel! // Displays the tip amount
    @IBOutlet weak var totalWithTip: UILabel! // Displays the total with tip included
    @IBOutlet weak var totalPerPerson: UILabel! // Displays the total per person
    
    @IBOutlet weak var clearButton: UIButton!
    /*
     Global Variables here
     */
    var billPrice: Double = 0
    var taxPercent: Double = 0
    var includeTax: Bool = true
    var tipPercent: Double = 0
    var numPeople: Int = 1
    
    
    // Function to handle when the bill amount is changed
    @IBAction func billAmountChanged(_ sender: UITextField) {
        updateUI()
    }
    // Function to handle when the tax percentage is changed
    @IBAction func taxPercentChanged(_ sender: UISegmentedControl) {
        updateUI()
    }
    // Function to handle when the include tax for tip option is changed
    @IBAction func includeTaxForTip(_ sender: UISwitch) {
        if inputIncludeTax.isOn{
            includeTax = true
        }
        else{
            includeTax = false
        }
        updateUI()
    }
    // Function to handle when the tip percentage is changed
    @IBAction func tipPercentChanged(_ sender: UISlider) {
        tipPercentLabel.text = "\(Int(enterTipPercent.value))%"
        updateUI()
    }
    // Function to handle when the number of people has changed
    @IBAction func peopleCountChanged(_ sender: UIStepper) {
        peopleCountLabel.text = "Split \(Int(enterNumPeople.value))"
        updateUI()
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Clear All Values", message: "Are you sure you want to clear all values?", preferredStyle: UIAlertController.Style.actionSheet)
        
        let clearButton = UIAlertAction(title: "Clear All", style: UIAlertAction.Style.destructive, handler: clearAll(_:))
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(clearButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // Helper function to update the UI components
    func updateUI(){
        if enterBill.hasText{
            billPrice = Double(enterBill.text!)!
            taxPercent = Double(enterTaxPercent.titleForSegment(at: enterTaxPercent.selectedSegmentIndex)!)!
            tipPercent = Double(enterTipPercent.value)
            numPeople = Int(enterNumPeople.value)
            
            
            let taxTotal = billPrice * taxPercent / Double(100)
            let subTot = billPrice + taxTotal
            
            
            var tipAmount: Double = 0
            if includeTax{
                tipAmount = subTot * (tipPercent / Double(100))
            }
            else{
                tipAmount = billPrice * (tipPercent / Double(100))
            }
            
            let totalPlusTip = subTot + tipAmount
            let totPerPerson = totalPlusTip / Double(numPeople)
            
            tax.text = String(format: "$%.2f", taxTotal)
            subTotal.text = String(format: "$%.2f", subTot)
            tip.text = String(format: "$%.2f", tipAmount)
            totalWithTip.text = String(format: "$%.2f", totalPlusTip)
            totalPerPerson.text = String(format: "$%.2f", totPerPerson)
            
        }
        return
    }
    
    func setDefaultValues(){
        billPrice = Double(0)
        enterBill.text = "0"
        updateUI()
        enterBill.text?.removeAll()
        enterTaxPercent.selectedSegmentIndex = 0
        inputIncludeTax.setOn(true, animated: true)
        enterTipPercent.value = 15
        tipPercentChanged(enterTipPercent)
        enterNumPeople.value = 1
        peopleCountChanged(enterNumPeople)
    }
    
    func clearAll(_ action: UIAlertAction) -> Void{
        setDefaultValues()
    }
    
}

