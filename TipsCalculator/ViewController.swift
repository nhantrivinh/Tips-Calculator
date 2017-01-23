//
//  ViewController.swift
//  TipsCalculator
//
//  Created by AndAnotherOne on 1/11/17.
//  Copyright © 2017 AndAnotherOne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var tfBill: UITextField!
    @IBOutlet weak var scTip: UISegmentedControl!
    @IBOutlet weak var viewLightSaber: UIView!
    
    var tipPercentages = [Double]()
    var firstLoad = true
    var currencySymbol = "USD"
    
    override func viewWillAppear(_ animated: Bool) {
        checkForUpdatedTipsAmount()
        checkForSavedColors()
        updateSegmentedTitles()
        updateLocalCurrency()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tfBill.becomeFirstResponder()
        checkForFirstLoad()
    }
    
    func checkForUpdatedTipsAmount() {
        let defaults = UserDefaults.standard
        if let bill = defaults.object(forKey: KEY_BILL_AMOUNT) as? Double {
            if bill != 0 {
                self.tfBill.text = "\(bill)"
            }
        }
        if let tip = defaults.object(forKey: KEY_TIP_AMOUNT) as? Double {
            self.lblTip.text = "\(tip) \(currencySymbol)"
        }
        if let selectedSegment = defaults.object(forKey: KEY_SELECTED_SEGMENT) as? Int {
            self.scTip.selectedSegmentIndex = selectedSegment
        }
        
        guard let tip1 = defaults.object(forKey: KEY_TIP_1) as? Double, let tip2 = defaults.object(forKey: KEY_TIP_2) as? Double, let tip3 = defaults.object(forKey: KEY_TIP_3) as? Double else { return }
        for i in 0...2 {
            let key = "KEY_TIP_\(i + 1)"
            print(defaults.object(forKey: key) as? Double)
            if let tip = defaults.object(forKey: key) as? Double {
                scTip.setTitle("\(tip)%", forSegmentAt: i)
            }
        }
    }
    
    func checkForSavedColors() {
        guard let data = UserDefaults.standard.object(forKey: KEY_COLOR) as? NSData else { return }
        guard let chosenColor = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? UIColor else { return }
        guard let currentColor = viewLightSaber.backgroundColor else { return }
        if currentColor != chosenColor {
            viewLightSaber.backgroundColor = chosenColor
            viewLightSaber.fadeAndStay()
        }
        
    }
    
    func updateSegmentedTitles() {
        tipPercentages = []
        for i in 0...scTip.numberOfSegments - 1 {
            let title = scTip.titleForSegment(at: i)!
            let percentage = Double(String(title.characters.dropLast())) ?? 0
            tipPercentages.append(percentage)
        }
        if !firstLoad {
            calculateTips(self)
        }
    }
    
    func checkForFirstLoad() {
        if firstLoad {
            let defaults = UserDefaults.standard
            for i in 0...2 {
                let key = "KEY_TIP_\(i+1)"
                defaults.set(tipPercentages[i], forKey: key)
            }
            self.checkForTimeElapsed()
        } else {
            return
        }
        firstLoad = false
    }
    
    func checkForTimeElapsed() {
        guard let dateInit = UserDefaults.standard.object(forKey: KEY_INIT_TIME) as? Date else {
            UserDefaults.standard.set(Date(), forKey: KEY_INIT_TIME)
            return
        }
        let dateNow = Date()
        let difference = dateNow.minutes(from: dateInit)
        if difference < 10 {
            let defaults = UserDefaults.standard
            let total = defaults.object(forKey: KEY_TOTAL_AMOUNT) as! Double
            print("TOTAL:", total)
            self.lblTotal.text = "\(total) \(currencySymbol)"
        }
    }
    
    func updateLocalCurrency() {
        let locale = Locale.current
        print("I am now at", locale)
        let currencySymbol = locale.currencySymbol
        let currencyCode = locale.currencyCode
        print(currencyCode)
        print(currencySymbol)
        print(self.currencySymbol)
        self.currencySymbol = currencyCode ?? "USD"
    }
    
    

    @IBAction func onTap(_ sender: Any) {
//        view.endEditing(true)
    }
    
    @IBAction func calculateTips(_ sender: Any) {
        let bill = Double(tfBill.text!) ?? 0
        let tip = (bill * tipPercentages[scTip.selectedSegmentIndex])/100
        print(tipPercentages)
        let total = bill + tip
        let defaults = UserDefaults.standard
        let selectedSegment = self.scTip.selectedSegmentIndex
        defaults.set(total, forKey: KEY_TOTAL_AMOUNT)
        defaults.set(selectedSegment, forKey: KEY_SELECTED_SEGMENT)
        defaults.set(bill, forKey: KEY_BILL_AMOUNT)
        defaults.set(tip, forKey: KEY_TIP_AMOUNT)
        defaults.synchronize()
        print("Saving as total:", total)
        let loadedTotal = UserDefaults.standard.object(forKey: KEY_TOTAL_AMOUNT)
        print("Loaded total:", loadedTotal)
        lblTip.text = String(format: "%.2f \(currencySymbol)", tip)
        lblTotal.text = String(format: "%.2f \(currencySymbol)", total)
        
    }
    

}

