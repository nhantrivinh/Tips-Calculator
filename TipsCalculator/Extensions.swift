//
//  Extensions.swift
//  TipsCalculator
//
//  Created by AndAnotherOne on 1/11/17.
//  Copyright © 2017 AndAnotherOne. All rights reserved.
//

import UIKit

extension UIView {
    func fade() {
        self.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 1
        }) { (complete) in
            UIView.animate(withDuration: 0.3, delay: 2, options: .curveEaseOut, animations: {
                self.alpha = 0
            }, completion: nil)
        }
    }
    
    func fadeAndStay() {
        self.alpha = 0
        UIView.animate(withDuration: 1, animations: { 
            self.alpha = 1
        }, completion: nil)
    }
}

extension UserDefaults {
    func set(_ color: UIColor, forKey key: String) {
        set(NSKeyedArchiver.archivedData(withRootObject: color), forKey: key)
    }
    func color(forKey key: String) -> UIColor? {
        guard let data = data(forKey: key) else { return nil }
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
    }
}

extension Date {
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
}
