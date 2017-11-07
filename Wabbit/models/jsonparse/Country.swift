//
//  Country.swift
//  Wabbit
//
//  Created by Luis Ezcurdia on 11/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

struct Country : Codable {
    let iso : String
    let name : String
    let languages : [String]
}
