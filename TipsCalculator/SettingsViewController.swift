//
//  SettingsViewController.swift
//  TipsCalculator
//
//  Created by AndAnotherOne on 1/11/17.
//  Copyright © 2017 AndAnotherOne. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var tfTip1: UITextField!
    @IBOutlet weak var tfTip2: UITextField!
    @IBOutlet weak var tfTip3: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblInstruction.alpha = 0
        lblError.alpha = 0
        var textfields = [tfTip1, tfTip2, tfTip3]
        for i in 0...textfields.count - 1 {
            let key = "KEY_TIP_\(i+1)"
            let amount = UserDefaults.standard.double(forKey: key)
            print(textfields)
            let textfield = textfields[i]
            textfield?.placeholder = "\(amount)%"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tfTip1.becomeFirstResponder()
    }

    @IBAction func btnColorTap(_ sender: UIButton) {
        let color = sender.backgroundColor
        let data : NSData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData
        UserDefaults.standard.set(data, forKey: KEY_COLOR)
        
        lblInstruction.fade()
    }

    @IBAction func changedTipAmount(_ sender: UITextField) {
        print("change tip amount")
        let amount = Double(sender.text!) ?? 0
        let defaults = UserDefaults.standard
        if sender == tfTip1 {
            defaults.set(amount, forKey: KEY_TIP_1)
        } else if sender == tfTip2 {
            defaults.set(amount, forKey: KEY_TIP_2)
        } else {
            defaults.set(amount, forKey: KEY_TIP_3)
        }
        
        
    }
}
