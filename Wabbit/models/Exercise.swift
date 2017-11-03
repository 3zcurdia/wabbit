//
//  Exercise.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

struct Exercise {
    let times : Int
    let warmup : UInt?
    
    func run(_ name : String, block : @escaping (()->Void) ) -> Report {
        var startTime : Date
        var endTime : Date
        var samples = [Double]()
        for _ in 0...(self.warmup ?? 5) { block() }
        for _ in 0..<self.times {
            startTime = Date()
            block()
            endTime = Date()
            samples.append(endTime.timeIntervalSince(startTime))
        }
        let avg = (samples.reduce(0,+)) / Double(samples.count)
        return Report(name: name, time: avg)
    }
}
