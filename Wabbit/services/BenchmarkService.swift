//
//  BenchmarkService.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/10/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class BenchmarkService {
    static let shared = BenchmarkService()
    lazy var lipsum : String = {
        guard let filepath = Bundle.main.path(forResource: "lipsum", ofType: "txt") else { return "lorem ipsum" }
        return (try? String(contentsOfFile: filepath)) ?? "lipsum"
    }()

    lazy var logo : UIImage = {
        guard let filepath = Bundle.main.path(forResource: "logo1128", ofType: "png") else { return UIImage() }
        return UIImage(contentsOfFile: filepath) ?? UIImage()
    }()

    lazy var json : String = {
        guard let filepath = Bundle.main.path(forResource: "countries", ofType: "json") else { return "[]" }
        return (try? String(contentsOfFile: filepath)) ?? "[]"
    }()

    func run(onUpdate update: @escaping (([ReportGroup])->Void), completion: @escaping (()->Void)) {
        DispatchQueue.global(qos: .background).async {
            var reports = [ReportGroup]()
            update(reports)
            reports.append(self.primeGroup())
            update(reports)
            reports.append(self.factorialGroup())
            update(reports)
            reports.append(self.sha1Group())
            update(reports)
            reports.append(self.sha256Group())
            update(reports)
            reports.append(self.base64Group())
            update(reports)
            reports.append(self.base64ImageGroup())
            update(reports)
            reports.append(self.jsonDecodeGroup())
            update(reports)
            DispatchQueue.main.async { completion() }
        }
    }

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

    func sha1Group() -> ReportGroup {
        return ReportGroup.build("SHA1", objcMethod: {
            _ = NSCrypto.shared().sha1String(self.lipsum)
        }, swiftMethod: {
            _ = Crypto.shared.sha1(string:self.lipsum)
        })
    }

    func sha256Group() -> ReportGroup {
        return ReportGroup.build("SHA256", objcMethod: {
            _ = NSCrypto.shared().sha256String(self.lipsum)
        }, swiftMethod: {
            _ = Crypto.shared.sha256(string:self.lipsum)
        })
    }

    func base64Group() -> ReportGroup {
        return ReportGroup.build("Base64 Text", objcMethod: {
            _ = NSCrypto.shared().base64String(self.lipsum)
        }, swiftMethod: {
            _ = Crypto.shared.base64(string:self.lipsum)
        })
    }

    func base64ImageGroup() -> ReportGroup {
        return ReportGroup.build("Base64 Image", objcMethod: {
            _ = NSCrypto.shared().base64Image(self.logo)
        }, swiftMethod: {
            _ = Crypto.shared.base64(image:self.logo)
        })
    }

    func jsonDecodeGroup() -> ReportGroup {
        return ReportGroup.build("JSON Decode", objcMethod: {
            _ = NSJsonParse.shared().parseAllCountries(from: self.json.data(using: .utf8))
        }, swiftMethod: {
            _ = JsonParse.shared.parseAllCountries(string: self.json)
        })
    }
}
