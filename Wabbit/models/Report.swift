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
    var baseline: Double?

    func ips() -> Int {
        return Int(1.0/time)
    }
    
    func miliseconds() -> Double {
        return (time*1000).rounded(toDigits: 10)
    }

    func baselineComparison() -> Double {
        guard let baselineTime = baseline else { return 1.0 }
        return self.time / baselineTime
    }
}

extension Sequence where Iterator.Element == Report {
    func baselineTime() -> Double? {
        let sorted = self.sorted(by: { $0.time < $1.time })
        return sorted.first?.time
    }
}

extension Double {
    func rounded(toDigits digits: Int) -> Double {
        let divisor = pow(10.0, Double(digits))
        return (self * divisor).rounded() / divisor
    }
}
