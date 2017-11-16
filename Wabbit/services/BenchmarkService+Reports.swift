//
//  BenchmarkService+Reports.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/16/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

protocol ReportGroupBenchmarks {
    func primeGroup() -> ReportGroup
    func factorialGroup() -> ReportGroup
    func fibonacciGroup() -> ReportGroup
    func sha1Group() -> ReportGroup
    func sha256Group() -> ReportGroup
    func base64Group() -> ReportGroup
    func base64ImageGroup() -> ReportGroup
    func jsonDecodeGroup() -> ReportGroup
    func stringConcatGroup() -> ReportGroup
    func charReplacementGroup() -> ReportGroup
    func matchGroup() -> ReportGroup
}

extension BenchmarkService {
    func primeGroup() -> ReportGroup {
        return ReportGroup.build("Prime", objcMethod: {
            _ = NSNumeric.shared().isPrimeLong(181)
        }, swiftMethod: {
            _ = Numeric.shared.isPrime(int: 181)
        })
    }
    
    func factorialGroup() -> ReportGroup {
        return ReportGroup.build("Factorial", objcMethod: {
            _ = NSNumeric.shared().factorialLong(13)
        }, swiftMethod: {
            _ = Numeric.shared.factorial(int: 13)
        })
    }
    
    func fibonacciGroup() -> ReportGroup {
        return ReportGroup.build("Fibonacci", objcMethod: {
            _ = NSNumeric.shared().fibonacci(15)
        }, swiftMethod: {
            _ = Numeric.shared.fibonacci(15)
        })
    }
    
    func sha1Group() -> ReportGroup {
        return ReportGroup.build("SHA1", objcMethod: {
            _ = NSCrypto.shared().sha1String(self.lipsum)
        }, swiftMethod: {
            _ = Crypto.shared.sha1(string: self.lipsum)
        })
    }
    
    func sha256Group() -> ReportGroup {
        return ReportGroup.build("SHA256", objcMethod: {
            _ = NSCrypto.shared().sha256String(self.lipsum)
        }, swiftMethod: {
            _ = Crypto.shared.sha256(string: self.lipsum)
        })
    }
    
    func base64Group() -> ReportGroup {
        return ReportGroup.build("Base64 Text", objcMethod: {
            _ = NSCrypto.shared().base64String(self.lipsum)
        }, swiftMethod: {
            _ = Crypto.shared.base64(string: self.lipsum)
        })
    }
    
    func base64ImageGroup() -> ReportGroup {
        return ReportGroup.build("Base64 Image", objcMethod: {
            _ = NSCrypto.shared().base64Image(self.logo)
        }, swiftMethod: {
            _ = Crypto.shared.base64(image: self.logo)
        })
    }
    
    func jsonDecodeGroup() -> ReportGroup {
        return ReportGroup.build("JSON Decode", objcMethod: {
            _ = NSJsonParse.shared().parseAllCountries(from: self.json.data(using: .utf8))
        }, swiftMethod: {
            _ = JsonParse.shared.parseAllCountries(string: self.json)
        })
    }
    
    func stringConcatGroup() -> ReportGroup {
        return ReportGroup.build("String concatenation", objcMethod: {
            _ = StringManipulation.shared.append(string: self.lipsum, to: self.lipsum)
        }, swiftMethod: {
            _ = NSStringManipulation.shared().append(self.lipsum, to: self.lipsum)!
        })
    }
    
    func charReplacementGroup() -> ReportGroup {
        return ReportGroup.build("Character Replacement", objcMethod: {
            _ = NSStringManipulation.shared().textWithNumbers(for: self.lipsum)
        }, swiftMethod: {
            _ = StringManipulation.shared.textWithNumbers(self.lipsum)
        })
    }
    
    func matchGroup() -> ReportGroup {
        return ReportGroup.build("Regex Match", objcMethod: {
            _ = NSStringManipulation.shared().matches(for: "i\\D", in: self.lipsum)
        }, swiftMethod: {
            _ = StringManipulation.shared.matches(for: "i\\D", in: self.lipsum)
        })
    }
}
