//
//  Report.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

struct Report {
    let name: String
    let time: Double
    func ips() -> Int {
        return Int(1.0/time)
    }
}
