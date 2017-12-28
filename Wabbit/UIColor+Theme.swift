//
//  UIColor+Theme.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

extension UIColor {
    static let yankeesBlue = UIColor(named: "yankees blue")!
    static let tangerine = UIColor(named: "tangerine")!
    static let platinum = UIColor(named: "platinum")!
    
    func opaque(by alpha: CGFloat) -> UIColor {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: nil) {
            return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return self
        }
    }
}
