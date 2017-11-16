//
//  BenchmarkService.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/10/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class BenchmarkService : ReportGroupBenchmarks {
    static let shared = BenchmarkService()
    lazy var lipsum: String = {
        guard let filepath = Bundle.main.path(forResource: "lipsum", ofType: "txt") else { return "lorem ipsum" }
        return (try? String(contentsOfFile: filepath)) ?? "lipsum"
    }()

    lazy var logo: UIImage = {
        guard let filepath = Bundle.main.path(forResource: "logo1128", ofType: "png") else { return UIImage() }
        return UIImage(contentsOfFile: filepath) ?? UIImage()
    }()

    lazy var json: String = {
        guard let filepath = Bundle.main.path(forResource: "countries", ofType: "json") else { return "[]" }
        return (try? String(contentsOfFile: filepath)) ?? "[]"
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
            reports.append(self.jsonDecodeGroup())
            update(reports)
            DispatchQueue.main.async { completion() }
        }
    }
}
