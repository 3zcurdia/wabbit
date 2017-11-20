//
//  BenchmarkService.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/10/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class BenchmarkService: ReportGroupBenchmarks {
    static let shared = BenchmarkService()
    lazy var lipsum: String = {
        guard let filepath = Bundle.main.path(forResource: "lipsum", ofType: "txt") else { return "lorem ipsum" }
        return (try? String(contentsOfFile: filepath)) ?? "lipsum"
    }()

    lazy var logo: UIImage = {
        guard let filepath = Bundle.main.path(forResource: "logo1128", ofType: "png") else { return UIImage() }
        return UIImage(contentsOfFile: filepath) ?? UIImage()
    }()

    lazy var json: Data? = {
        guard let filepath = Bundle.main.path(forResource: "countries", ofType: "json") else { return "[]".data(using: .utf8) }
        let jsonString = (try? String(contentsOfFile: filepath)) ?? "[]"
        return jsonString.data(using: .utf8)
    }()

    lazy var countries: [Country] = {
        guard let unwrappedCountries = self.json else { return JsonParse.shared.defaultDecoded }
        return JsonParse.shared.decodeAllCountries(data: unwrappedCountries)
    }()

    func run(onUpdate update: @escaping (([ReportGroup]) -> Void), completion: @escaping (() -> Void)) {
        DispatchQueue.global(qos: .background).async {
            var reports = [ReportGroup]()
            update(reports)
            reports.append(self.primeGroup())
            update(reports)
            reports.append(self.factorialGroup())
            update(reports)
            reports.append(self.fibonacciGroup())
            update(reports)
            reports.append(self.stringConcatGroup())
            update(reports)
            reports.append(self.charReplacementGroup())
            update(reports)
            reports.append(self.matchGroup())
            update(reports)
            reports.append(self.sha1Group())
            update(reports)
            reports.append(self.sha256Group())
            update(reports)
            reports.append(self.base64Group())
            update(reports)
            reports.append(self.base64ImageGroup())
            update(reports)
            if let unwrapedJson = self.json {
                reports.append(self.jsonDecodeGroup(data: unwrapedJson))
                update(reports)
                reports.append(self.jsonEncodeGroup())
                update(reports)
            }
            DispatchQueue.main.async { completion() }
        }
    }
}
