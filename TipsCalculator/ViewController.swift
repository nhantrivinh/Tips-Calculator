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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        

//        if let tip1 = tip1 = defaults.object(forKey: KEY_TIP_1) as? Double {
//            
//        }
        let defaults = UserDefaults.standard
        guard let tip1 = defaults.object(forKey: KEY_TIP_1) as? Double, let tip2 = defaults.object(forKey: KEY_TIP_2) as? Double, let tip3 = defaults.object(forKey: KEY_TIP_3) as? Double else { return }
        for i in 0...2 {
            let title = "tip\(i + 1)"
            scTip.setTitle(title, forSegmentAt: i)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tfBill.becomeFirstResponder()
        checkForSavedColor()
    }
    
    func checkForSavedColor() {
        guard let data = UserDefaults.standard.object(forKey: KEY_COLOR) as? NSData else { return }
        guard let color = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? UIColor else { return }
        viewLightSaber.backgroundColor = color
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTips(_ sender: Any) {
        let tipPercentages = [0.18, 0.2, 0.25]
        let bill = Double(tfBill.text!) ?? 0
        let tip = bill * tipPercentages[scTip.selectedSegmentIndex]
        let total = bill + tip
        
        lblTip.text = String(format: "$%.2f", tip)
        lblTotal.text = String(format: "$%.2f", total)
    }
    

}

