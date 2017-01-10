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
    
    override func viewWillAppear(_ animated: Bool) {
        lblInstruction.alpha = 0
    }

    @IBAction func btnColorTap(_ sender: UIButton) {
        let color = sender.backgroundColor
        
        let data : NSData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData
        UserDefaults.standard.set(data, forKey: KEY_COLOR)
        
        lblInstruction.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.lblInstruction.alpha = 1
        }) { (complete) in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
                self.lblInstruction.alpha = 0
            }, completion: nil)
        }
    }

}
