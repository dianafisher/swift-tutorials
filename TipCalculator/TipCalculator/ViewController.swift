//
//  ViewController.swift
//  TipCalculator
//
//  Created by Diana Fisher on 4/6/15.
//  Copyright (c) 2015 Sparkly Hooves. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    // set up properties
    @IBOutlet var totalTextField: UITextField!  // ! indicates the values are optional, but they are implicitly unwrapped.
    @IBOutlet var taxPctSlider: UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // refresh the UI
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Declare callback functions from the view
    @IBAction func calculateTapped(sender: AnyObject) {
        
//        // Convert to an NSString and convert to Double
//        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
//        
//        let possibleTips = tipCalc.returnPossibleTips()
//        var results = ""
//        
//        // Enumerate through keys and values of the dictionary at the same time.
//        for (tipPct, tipValue) in possibleTips {
//            // Build the string of results
//            results += "\(tipPct)%: \(tipValue)\n"
//        }
//        
//        resultsTextView.text = results
        
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        tableView.reloadData()
    }
    
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100
        refreshUI()
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        totalTextField.resignFirstResponder()
    }
    
    let tipCalc = TipCalculatorModel(total: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt:Double, total:Double)>()
    var sortedKeys:[Int] = []
    
    func refreshUI() {
        // Convert total from a Double to a String
        totalTextField.text = String(format: "%0.2f", tipCalc.total)

        // Display the tax percentage as an integer
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        
        // Use string interpolation to update the label based on the tax percentage
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        
        // Clear the results text until the user taps the calculate button
//        resultsTextView.text = ""
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        
        let tipPct = sortedKeys[indexPath.row]
        
        let tipAmt = possibleTips[tipPct]!.tipAmt  // force unwrapping (with !) since we are sure the dictionary contains a value for this key
        let total = possibleTips[tipPct]!.total
        
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
        return cell
    }

}

