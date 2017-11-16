//
//  StringManipulation.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/15/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class StringManipulation {
    static let shared = StringManipulation()

    func textWithNumbers(_ str: String) -> String {
        var out = str.replacingOccurrences(of: "o", with: "0")
        out = out.replacingOccurrences(of: "i", with: "1")
        out = out.replacingOccurrences(of: "z", with: "2")
        out = out.replacingOccurrences(of: "e", with: "3")
        out = out.replacingOccurrences(of: "a", with: "4")
        out = out.replacingOccurrences(of: "s", with: "5")
        out = out.replacingOccurrences(of: "b", with: "6")
        out = out.replacingOccurrences(of: "t", with: "7")
        out = out.replacingOccurrences(of: "B", with: "8")
        out = out.replacingOccurrences(of: "g", with: "9")
        return out
    }

    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func append(string str: String, to: String) -> String {
        return "\(str)/\(to)"
    }
}
