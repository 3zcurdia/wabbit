//
//  Benchmark.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class Benchmark {
    static let sharedSession = Benchmark()
    let times: Int
    let warmup: UInt

    init(times: Int = 1_000, warmup: UInt = 5) {
        self.times = times
        self.warmup = warmup
    }

    func run(_ name: String, block : @escaping VoidFuncClosure) -> Report {
        var startTime: Date
        var endTime: Date
        var samples = [Double]()
        for _ in 0..<self.warmup { block() }
        for _ in 0..<self.times {
            startTime = Date()
            block()
            endTime = Date()
            samples.append(endTime.timeIntervalSince(startTime))
        }
        let sum = samples.reduce(0, +)
        if samples.count > 10 {
            if let min = samples.min(), let max = samples.max() {
                let minmax = min + max
                return Report(name: name, time: (sum - minmax) / Double(samples.count-2), baseline: nil)
            }
        }
        return Report(name: name, time: sum / Double(samples.count), baseline: nil)

    }
}
