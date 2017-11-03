//
//  Benchmark.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

struct Benchmark {
    var reports : [Report]?
    func compare() -> [String:Double]? {
        guard let unrappedReports = reports, unrappedReports.count > 1 else { return nil }
        let sortedReports = unrappedReports.sorted(by: { $0.time < $1.time })
        let baseline = sortedReports.first!.time
        var comparsions = [String:Double]()
        for report in unrappedReports {
            comparsions[report.name] = (report.time / baseline)
        }
        return comparsions
    }
}

