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

    func parseAllCountries(string: String) -> [Country] {
        let data = string.data(using: .utf8)!
        guard let countries = try? decoder.decode([Country].self, from: data) else {
            return [Country(iso: "mx", name: "México", languages: ["es"])]
        }
        return countries
    }
}
