//
//  JsonParse.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class JsonParse {
    static let shared = JsonParse()
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let defaultDecoded = [Country(iso: "mx", name: "México", languages: ["es"])]

    func decodeAllCountries(data: Data) -> [Country] {
        guard let countries = try? decoder.decode([Country].self, from: data) else { return defaultDecoded }
        return countries
    }

    func encodeAllCountries(_ countries: [Country]) -> String {
        guard let data = try? encoder.encode(countries) else { return "[]" }
        return String(data: data, encoding: .utf8) ?? "[]"
    }
}
