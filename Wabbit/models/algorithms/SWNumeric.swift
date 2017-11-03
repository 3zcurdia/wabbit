//
//  SWNumeric.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class SWNumeric {
    static let shared = SWNumeric()
    
    func factorial(int number:Int64) -> Int64 {
        if number < 1 {
            return 1
        } else {
           return number * factorial(int: number-1)
        }
    }
    
    func isPrime(int number:Int64) -> Bool {
        if number < 2 { return false }
        if number == 3 { return true }
        let n = Int64(sqrt(Double(number)))
        for i in 2...n {
            if number % i == 0 {
                return false
            }
        }
        return true
    }
}
